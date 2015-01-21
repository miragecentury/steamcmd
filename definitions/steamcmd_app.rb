define :steamcmd_app, :app_id => nil, :app_name => nil, :app_game => nil, :cfg_file => nil, :needAuth => nil do

  include_recipe 'steamcmd::default'

  if node['steamcmd']['create_symlinks']
    link "#{node['steamcmd']['home']}/#{params[:app_name]}" do
      to "#{node['steamcmd']['apps_dir']}/#{params[:app_id]}"
      action :create
    end
  end

  dir = "#{node['steamcmd']['apps_dir']}/#{params[:app_id]}"
  params[:cfg_file] = "#{dir}/#{params[:cfg_file]}"

  if params[:needAuth] != TRUE
    execute "install #{params[:app_name]}" do
      only_if {
        !::File.directory?(dir) ||
            (::File.directory?(dir) && ::Dir.entries(dir).empty?)
      }
      user node['steamcmd']['user']
      group node['steamcmd']['group']
      cwd node['steamcmd']['apps_dir']
      command "#{node['steamcmd']['steamcmd_dir']}/steamcmd.sh +login anonymous +force_install_dir #{dir} +app_update #{params[:app_id]} validate +quit"
      action :run
      retries 3
      retry_delay 5
    end
  end

  if params[:needAuth] == TRUE
    execute "install #{params[:app_name]}" do
      only_if {
        !::File.directory?(dir) ||
            (::File.directory?(dir) && ::Dir.entries(dir).empty?)
      }
      user node['steamcmd']['user']
      group node['steamcmd']['group']
      cwd node['steamcmd']['apps_dir']
      command "#{node['steamcmd']['steamcmd_dir']}/steamcmd.sh '+login #{node['steamcmd']['steam']['username']} #{node['steamcmd']['steam']['password']} +force_install_dir #{dir} +app_update #{params[:app_id]} validate +quit'"
      action :run
      retries 3
      retry_delay 5
    end
  end

end