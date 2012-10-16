class ImportedFile < ActiveRecord::Base
  
  def self.find_distinct(column_name)
    statement = "select distinct #{column_name} from imported_files order by #{column_name}"
    sanitized = ActiveRecord::Base.sanitize_sql_array([statement])
    ImportedFile.find_by_sql(sanitized).collect do |row|
      row[column_name]
    end
  end
  
end
