ActionController::Routing::Routes.draw do |map|
  # map.resources :cmvcs

  map.resources :users, :except => [ :new, :create, :delete ], :has_one => :cmvc

  # Path for swinfos
  map.swinfos('swinfos/:item',
             :controller => 'swinfos',
             :action => 'show',
             :item => /.*/)
  map.swinfos_form('swinfos',
                   :controller => 'swinfos',
                   :action => 'show')
  
  # Path for which_filesets
  map.which_filesets('which_filesets/*path',
                     :controller => 'which_filesets',
                     :action => 'show')
  map.which_filesets_form('which_filesets',
                          :controller => 'which_filesets',
                          :action => 'show')

  # Special path for CMVC changes
  map.changes('changes/:id',
              :controller => 'changes',
              :action => 'show')
  map.changes_form('changes',
                   :controller => 'changes',
                   :action => 'show')

  # Special path for file changes
  map.file_changes('file_changes/:file',
                   :file => /.*/,
                   :controller => 'file_changes',
                   :action => 'show')
  map.file_changes_form('file_changes',
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

  # Special path for ptf apar def constants
  map.resources :ptf_apar_defs, :only => [ :show ]

  # Special path to the apar draft reflector.
  map.apar_drafts('apar_drafts/:search_type/:search_arg',
                  :controller => 'apar_drafts',
                  :search_type => /defect|apar|pmr/,
                  :action => 'show')

  # Normal resource paths created by rake for basic database forms.
  map.resources :aix_files, :only => [ :index, :show ]
  map.resources :apar_defect_ptf_release_maps, :only => [ :index, :show ]
  map.resources :apars, :only => [ :index, :show ]
  map.resources :defects, :only => [ :index, :show ]
  map.resources :families, :only => [ :index, :show ]
  map.resources :fileset_aix_file_maps, :only => [ :index, :show ]
  map.resources :fileset_ptf_maps, :only => [ :index, :show ]
  map.resources :filesets, :only => [ :index, :show ]
  map.resources :image_path_fileset_maps, :only => [ :index, :show ]
  map.resources :image_path_package_maps, :only => [ :index, :show ]
  # map.resources :image_paths
  map.resources :lpp_bases, :only => [ :index, :show ]
  map.resources :lpps, :only => [ :index, :show ]
  map.resources :package_fileset_maps, :only => [ :index, :show ]
  map.resources :packages, :only => [ :index, :show ]
  map.resources :ptfs, :only => [ :index, :show ]
  map.resources :releases, :only => [ :index, :show ]
  map.resources :service_pack_fileset_maps, :only => [ :index, :show ]
  map.resources :service_packs, :only => [ :index, :show ]

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "welcome"
end
