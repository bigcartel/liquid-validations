module LiquidValidations
  
  def validates_liquid_of(*attr_names)
    configuration = { :message => I18n.translate('activerecord.errors.messages')[:invalid], :on => :save }
    configuration.update(attr_names.extract_options!)

    validates_each(attr_names, configuration) do |record, attr_name, value|
      errors = []
      
      begin
        template = Liquid::Template.parse(value.to_s)
        errors  += template.errors
      rescue Exception => e
        errors << e.message
      end    
      
      for error in errors
        record.errors.add_to_base(friendly_liquid_error(error) + " in your #{attr_name}")
      end
      
    end    
  end
  
  def validates_presence_of_liquid_variable(*attr_names)
    configuration = { :message => I18n.translate('activerecord.errors.messages')[:invalid], :on => :save, :variable => nil, :container => nil }
    configuration.update(attr_names.extract_options!)

    raise(ArgumentError, "You must supply a variable to check for") if configuration[:variable].blank?
    
    validates_each(attr_names, configuration) do |record, attr_name, value|
      
      value         = value.to_s
      
      variable      = configuration[:variable].to_s
      variable_re   = /\{\{\s*#{variable}( .*)?\}\}/

      container     = configuration[:container].to_s
      container_re  = /<\s*#{container}.*>.*#{variable_re}.*<\/\s*#{container}\s*>/im

      if container.blank? && !(value =~ variable_re)
        
        record.errors.add_to_base("You must include \\\\{{ {{ #{variable} }} }} in your #{attr_name.humanize.downcase}") 
      
      elsif !container.blank? && !(value =~ container_re)
      
        record.errors.add_to_base("You must include \\\\{{ {{ #{variable} }} }} inside the <#{container}> tag of your #{attr_name.humanize.downcase}")
      
      end   
    end
  end
  
  private
  
  def friendly_liquid_error(error)
    error.gsub('liquid', '').
          gsub('Liquid', '').
          gsub(/terminated with regexp:.+/, 'closed')
  end
  
end