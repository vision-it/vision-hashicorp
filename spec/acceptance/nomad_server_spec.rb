# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'vision_hashicorp::nomad::server' do
  context 'with defaults' do
    it 'run idempotently' do
      pp = <<-FILE
        class { 'vision_hashicorp::nomad::server': }
      FILE

      apply_manifest(pp, catch_failures: false)
    end
  end

  context 'packages installed' do
    describe package('nomad') do
      it { is_expected.to be_installed }
    end
  end
  context 'config provisioned' do
    describe file('/etc/nomad.d/nomad.hcl') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match 'Puppet' }
      its(:content) { is_expected.to match 'encrypt' }
      its(:content) { is_expected.to match 'telemetry' }
    end
    describe file('/etc/nomad.d/anonymous.policy') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match 'Puppet' }
      its(:content) { is_expected.to match 'deny' }
    end
    describe file('/etc/nomad.d/operator.policy') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match 'Puppet' }
      its(:content) { is_expected.to match 'read-job' }
    end
    describe file('/etc/systemd/system/nomad.service') do
      it { is_expected.to exist }
      its(:content) { is_expected.to match 'Puppet' }
      its(:content) { is_expected.to match 'data.mount' }
    end
  end
end
