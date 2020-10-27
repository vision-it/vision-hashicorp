# frozen_string_literal: true

require 'spec_helper'
require 'hiera'

describe 'vision_hashicorp::consul::service' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let(:title) { 'foobar' }

      let(:params) {
        {
          'port' => 1234,
          'address' => '127.0.0.1',
          'tags' => %w[one two],
          'checks' => [{ 'interval': '10s' }]
        }
      }

      context 'compile' do
        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end
