module PuppetX
  module Mssql
    class Helper
      @features_hash = {
          :SQLEngine => 'Database Engine Services',
          :Replication => 'SQL Server Replication',
          :FullText => 'Full-Text and Semantic Extractions for Search',
          :DQ => 'Data Quality Services',
          :BC => 'Client Tools Backwards Compatibility',
          :SSMS => 'Management Tools - Basic',
          :ADV_SSMS => 'Management Tools - Complete',
          :Conn => 'Client Tools Connectivity',
          :SDK => 'Client Tools SDK'
      }

      def self.is_domain_user?(user, hostname)
        if /(^(((nt (authority|service))|#{hostname})\\\w+)$)|^(\w+)$/i.match(user)
          false
        else
          true
        end
      end

      def self.create_sqlcmd_query(query)
        query_array = ['-Q',
                       "#{query}",
                       '-d', 'master',
                       '-U', 'access_db',
                       '-P', "Pupp3t1@",
                       '-h-1',
                       '-W',
                       '-s', ',']
      end

      def self.translate_features(features)
        translated = []
        Array.new(features).each do |feature|
          if @features_hash.has_value?(feature)
            translated << @features_hash.key(feature)
          end
        end
        translated.sort
      end
    end
  end
end