Dayssince.controllers  do
  # {{{
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end
  # }}}

  layout :layout

  get :index do
    @today = Date.today
    @tasks = Task.where(:uid => current_account.uid)
    render :counter
  end

  get :login do
    render :login
  end

  post :create do
    task = Task.new
    task.uid = current_account.uid
    task.value = params[:task_name].force_encoding('UTF-8') # 日本語エラーでよる
    task.last_update = Time.now - params[:days_ago].to_i*24*60*60
    result = task.save
    added_task = Task.find(task.id)
    @msg = {
      :result => result ? 200 : 400,
      :days_ago => '%03d' % (Date.today - added_task.last_update).to_i,
      :task_name => added_task.value,
    }.to_json
  end

  get :update do

  end

  get :delete do
  end

  get :logout do
    set_current_account(nil)
    redirect url(:index)
  end

  get :auth, :map => '/auth/:provider/callback' do
    auth    = request.env["omniauth.auth"]
    account = Account.find_by_provider_and_uid(auth["provider"], auth["uid"]) || Account.create_with_omniauth(auth)
    set_current_account(account)
    redirect "http://" + request.env["HTTP_HOST"] + url(:index)
  end
end

Dayssince.controllers :api do
  get :index, :provides => :json do
  end
end
