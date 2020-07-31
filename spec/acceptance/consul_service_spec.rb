require 'spec_helper_acceptance'

describe 'vision_hashicorp::consul::service' do
  context 'with defaults' do
    it 'run idempotently' do
      pp = <<-FILE
        vision_hashicorp::consul::service { 'foobar':
         port => 8080,
         address => '127.0.0.1',
         tags => ['one', 'two'],
         checks => [{'interval' => '10s'}],
        }
      FILE

      apply_manifest(pp, catch_failures: false)
    end
  end

  context 'service created' do
    describe file('/etc/consul.d/service_foobar.json') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match 'Puppet' }
      its(:content) { is_expected.to match '8080' }
      its(:content) { is_expected.to match '"interval":"10s"' }
    end
  end
end
