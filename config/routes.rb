ActionController::Routing::Routes.draw do |map|
  # Path for swinfos
  map.swinfos('swinfos/:item',
              :controller => 'swinfos',
              :action => 'show',
              :item => /.*/)
  
  # Path for which_filesets
  map.which_filesets('which_filesets/*path',
                     :controller => 'which_filesets',
                     :action => 'show')

  # Special path for CMVC changes
  map.changes('changes/:id',
              :controller => 'changes',
              :action => 'show')

  # Special path for file changes
  map.file_changes('file_changes/:file',
                   :file => /.*/,
                   :controller => 'file_changes',
                   :action => 'show')

  # Special path for CMVC source files
  map.src_files('src_files/:release/*path/:version',
                :controller => 'src_files',
                :action => 'show',
                :version => /[1-9][0-9]*(\.[1-9][0-9]*)+/ )

  # Special path for diffs
  map.diffs('diffs/:release/*path/:version',
            :controller => 'diffs',
            :action => 'show',
            :version => /[1-9][0-9]*(\.[1-9][0-9]*)+/ )

  # Special path for image paths
  map.image_paths('image_paths/*path',
                  :controller => 'image_paths',
                  :action => 'show')

  # Normal resource paths created by rake for basic database forms.
  map.resources :aix_files  
  map.resources :apar_defect_ptf_release_maps
  map.resources :apars
  map.resources :defects
  map.resources :families
  map.resources :fileset_aix_file_maps
  map.resources :fileset_ptf_maps
  map.resources :filesets
  map.resources :image_path_fileset_maps
  map.resources :image_path_package_maps
  # map.resources :image_paths
  map.resources :lpp_bases
  map.resources :lpps
  map.resources :package_fileset_maps
  map.resources :packages
  map.resources :ptf_apar_defs
  map.resources :ptfs
  map.resources :releases
  map.resources :service_pack_fileset_maps
  map.resources :service_packs

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
