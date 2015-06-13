require_relative '../../../lib/jobs/job_factory'
require 'spec_helper'

module Jobs
  describe JobFactory do
    context 'when the job exists' do
      it 'finds the job' do
        j = Job.create!(title: 'realjob', 
                        company_attributes: {name: 'defaultco'})
        f = JobFactory.new        
        job_attrs = {
          title: 'realjob',
          company_attributes: {
            name: 'defaultco'
          }
        }
        expect(f.produce(job_attrs)).to eq j
      end
      
      it 'updates the job with any new attributes' do
        Job.create!(title: 'realjob', 
                        company_attributes: {name: 'defaultco'})
        f = JobFactory.new        
        job_attrs = {
          title: 'realjob',
          description: 'Doing Real Things',
          company_attributes: {
            name: 'defaultco',
          }
        }
        
        produced = f.produce(job_attrs)
        expect(produced.description).to eq 'Doing Real Things'
      end
      
      it 'updates the company with any new attributes' do
        j = Job.create!(title: 'realjob', 
                        company_attributes: {name: 'defaultco'})
        f = JobFactory.new        
        job_attrs = {
          title: 'realjob',
          company_attributes: {
            name: 'defaultco',
            description: 'A Real Company'
          }
        }
        
        produced = f.produce(job_attrs)
        expect(produced.company.description).to eq 'A Real Company'
      end
      
      it 'does not create a new job' do
        Job.create!(title: 'realjob', 
                        company_attributes: {name: 'defaultco'})
        f = JobFactory.new        
        job_attrs = {
          title: 'realjob',
          description: 'Doing Real Things',
          company_attributes: {
            name: 'defaultco',
          }
        }
        
        f.produce(job_attrs)
        expect(Job.count).to eq 1
      end
    end
    
    context 'when the job does not exist' do
      context 'and the job company does not exist' do
        it 'creates the job' do
          f = JobFactory.new        
          job_attrs = {
            title: 'realjob',
            description: 'Doing Real Things',
            company_attributes: {
              name: 'defaultco',
            }
          }
        
          f.produce(job_attrs)
          expect(Job.count).to eq 1
          expect(Job.first.description).to eq 'Doing Real Things'
        end
        
        it 'creates the company' do
          f = JobFactory.new        
          job_attrs = {
            title: 'realjob',
            company_attributes: {
              name: 'defaultco',
              description: 'A Real Company'
            }
          }
        
          f.produce(job_attrs)
          expect(Company.count).to eq 1
          expect(Company.first.description).to eq 'A Real Company'
        end
      end
      
      context 'and the job company does exist' do
        it 'creates the job' do
          Company.create!(name: 'defaultco')
          
          f = JobFactory.new        
          job_attrs = {
            title: 'realjob',
            company_attributes: {
              name: 'defaultco'
            }
          }
        
          produced = f.produce(job_attrs)
          expect(Job.count).to eq 1
        end
        
        it 'references the company' do
          c = Company.create!(name: 'defaultco')
          
          f = JobFactory.new        
          job_attrs = {
            title: 'realjob',
            company_attributes: {
              name: 'defaultco'
            }
          }
        
          produced = f.produce(job_attrs)
          expect(produced.company).to eq c
        end
        
        it 'does not create a new company' do
          Company.create!(name: 'defaultco')
          
          f = JobFactory.new        
          job_attrs = {
            title: 'realjob',
            company_attributes: {
              name: 'defaultco'
            }
          }
        
          f.produce(job_attrs)
          expect(Company.count).to eq 1
        end
        
        # NOTE: We may not want this. Multiple jobs updating companies with new attributes all the time -- seems kinda funny! Filing bug/chore. Return.
        it 'updates the nested company with any new attributes' do
          Company.create!(name: 'defaultco')
          
          f = JobFactory.new        
          job_attrs = {
            title: 'realjob',
            company_attributes: {
              name: 'defaultco',
              description: 'A Real Company'
            }
          }
        
          produced = f.produce(job_attrs)
          expect(produced.company.description).to eq 'A Real Company'
        end
      end
    end
  end
end