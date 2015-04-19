require_relative '../../../lib/jobs/angel_client'

module Jobs
  describe AngelClient do
    context 'getting jobs' do
      it 'queries the angellist Jobs API' do
        client = AngelClient.new
        expect(URI).to receive(:parse)
          .with(/https:\/\/api.angel.co\/1\/jobs/).and_call_original
        client.get_jobs
      end
    end
  end
end