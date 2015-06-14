module Jobs
  class JobFactory
    def produce(job_attrs)
      co_attrs = job_attrs.delete(:company_attributes)
      loc_attrs = job_attrs.delete(:location_attributes)
      
      co = Company.find_by(name: co_attrs[:name]) || Company.new(co_attrs) || Company.unknown_co
      co.update_attributes!(co_attrs)
      job_attrs[:company] = co
      
      l = loc_attrs ? Location.find_by(loc_attrs) || Location.new(loc_attrs) : Location.unknown_location
      job_attrs[:location] = l
      
      j = Job.find_by_title_and_company_name(
        job_attrs[:title],
        co_attrs[:name]
      ) || Job.new(job_attrs)
      j.update_attributes!(job_attrs)
      
      j.save!
      j
    end
  end
end