require 'spec_helper'

describe 'chef_ec2_cli_tools::api' do
  let(:chef_run) { runner.converge 'chef_ec2_cli_tools::api' }

  it_behaves_like 'ec2 cli tools', 'api'

  it "installs java" do
    expect(chef_run).to include_recipe 'java'
  end

  it "exports the AWS_ACCESS_KEY and AWS_SECRET_KEY" do
    expect(chef_run).to create_file_with_content '/etc/profile.d/aws_keys.sh',
                                             "export AWS_ACCESS_KEY=#{@runner.node['chef_ec2_cli_tools']['aws_access_key']}"
    expect(chef_run).to create_file_with_content '/etc/profile.d/aws_keys.sh',
                                             "export AWS_SECRET_KEY=#{@runner.node['chef_ec2_cli_tools']['aws_secret_key']}"
    expect(chef_run.template('/etc/profile.d/aws_keys.sh')).to be_owned_by('root', 'root')
  end
end
