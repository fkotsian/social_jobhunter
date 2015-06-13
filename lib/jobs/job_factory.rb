module Jobs
  class JobFactory
    def produce(job_attrs)
      # if Job exists
        # find it
        # update it
      # if not
        # create it
        
      co_attrs = job_attrs.delete(:company_attributes)
      if co_attrs
        co = Company.find_by(name: co_attrs[:name]) || Company.new(co_attrs) || Company.unknown_co
        co.update_attributes!(co_attrs)
      else
        co = Company.unknown_co
      end
      job_attrs[:company] = co
      
      j = Job.find_by_title_and_company_name(
        job_attrs[:title],
        co_attrs[:name]
      ) || Job.new(job_attrs)
      j.update_attributes!(job_attrs)
      j.save!

      byebug if j.company_id.nil?
      j
    end
  end
end