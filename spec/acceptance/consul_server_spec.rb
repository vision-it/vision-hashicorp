# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'vision_hashicorp::consul::server' do
  context 'with defaults' do
    it 'run idempotently' do
      pp = <<-FILE
        class { 'vision_hashicorp::consul::server': }
      FILE

      apply_manifest(pp, catch_failures: false)
    end
  end

  context 'packages installed' do
    describe package('consul') do
      it { is_expected.to be_installed }
    end
  end
  context 'config provisioned' do
    describe file('/etc/consul.d/consul.hcl') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match 'Puppet' }
      its(:content) { is_expected.to match 'encrypt' }
      its(:content) { is_expected.to match 'server = true' }
    end
  end
end
