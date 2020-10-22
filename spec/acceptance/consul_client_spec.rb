require 'spec_helper_acceptance'

describe 'vision_hashicorp::consul::client' do
  context 'with defaults' do
    it 'run idempotently' do
      setup = <<-FILE
        file {'/etc/dhcp/dhclient-enter-hooks.d/':
          ensure => directory,
        }
      FILE

      apply_manifest(setup, catch_failures: false)

      pp = <<-FILE
        class { 'vision_hashicorp::consul::client': }
      FILE

      # systemd not working in Docker
      apply_manifest(pp, catch_failures: false)
    end
  end

  context 'packages installed' do
    describe package('consul') do
      it { is_expected.to be_installed }
    end
    describe package('dnsmasq') do
      it { is_expected.to be_installed }
    end
  end
  context 'config provisioned' do
    describe file('/etc/consul.d/consul.hcl') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match 'Puppet' }
      its(:content) { is_expected.to match 'server = false' }
    end
    describe file('/etc/consul.d/service_example.json') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match 'foobar' }
      its(:content) { is_expected.to match '1234' }
    end
    describe file('/etc/dnsmasq.conf') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match '127.0.0.1' }
    end
    describe file('/etc/dnsmasq.d/10-consul') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match '127.0.0.1' }
    end
    describe file('/etc/dhcp/dhclient-enter-hooks.d/keep-resolv') do
      it { is_expected.to exist }
      it { should be_mode 755 }
      its(:content) { is_expected.to match 'Puppet' }
      its(:content) { is_expected.to match 'make_resolv_conf' }
    end
    describe file('/etc/resolv.conf') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match '127.0.0.1' }
    end
  end
end
