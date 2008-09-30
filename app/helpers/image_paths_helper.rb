module ImagePathsHelper
  def link_to_dir(dir)
    path = dir.base_path.split('/')
    link_to path.join('/'), "#{image_paths_path(path)}.html"
  end

  def link_to_image(image)
    path = image.path.split('/')
    link_to path.join('/'), "#{image_paths_path(path)}.html"
  end
end
