#inspired from redmine Redmine::Configuration
module PtSummaryReports
  module Configuration
    @@defaults = {}
    class << self
      def config
        @@config ||= load
      end

      def load(options={})
        options ||= {}
        filename = options[:file] || File.join(Rails.root, 'config', 'configuration.yml')
        env = options[:env] || Rails.env

        conf = @@defaults.dup
        if File.file?(filename)
          conf.merge!(load_from_yaml(filename, env))
        end
        conf
      end

      def [](value)
        config[value]
      end

      private
      
      #taken from Redmine::Configuration
      def load_from_yaml(filename, env)
        yaml = nil
        begin
          yaml = YAML::load_file(filename)
        rescue ArgumentError
          $stderr.puts "Your PtSummaryReports configuration file located at #{filename} is not a valid YAML file and could not be loaded."
          exit 1
        end
        conf = {}
        if yaml.is_a?(Hash)
          if yaml['default']
            conf.merge!(yaml['default'])
          end
          if yaml[env]
            conf.merge!(yaml[env])
          end
        else
          $stderr.puts "Your PtSummaryReports configuration file located at #{filename} is not a valid Redmine configuration file."
          exit 1
        end
        conf
      end
      
    end #end of class << self
  end  #end of module Configuration
end #end of module PtSummaryReports
