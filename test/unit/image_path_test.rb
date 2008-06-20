require 'test_helper'

class ImagePathTest < ActiveSupport::TestCase
  fixtures :image_paths, :packages
  
  def test_add_image_path_package_map
    ip = ImagePath.find(:first)
    pk = Package.find(:first)
    assert ip.image_path_package_maps.find_or_create_by_package_id(pk.id)

    ip2 = ImagePath.find(:first)
    pk2 = Package.find(:first)
    assert ip2.image_path_package_maps.find_or_create_by_package_id(pk2.id)
  end

  def test_add_package
    ip = ImagePath.find(:first)
    pk = Package.find(:first)
    ip.packages << pk unless ip.packages.find_by_name(pk.name)
    assert ip.save
    assert ImagePathPackageMap.find_by_image_path_id_and_package_id(ip.id, pk.id)

    ip2 = ImagePath.find(:first)
    pk2 = Package.find(:first)
    ip2.packages << pk unless ip2.packages.find_by_name(pk2.name)
    assert ip2.save
  end

  def test_add_package_with_find_1
    ip = ImagePath.find(:first)
    unless ip.packages.find_by_name("banana")
      ip.packages << Package.find_or_initialize_by_name("banana")
    end
    assert ip.save, "Image path not saved"
    assert ip.packages.find_by_name("banana"), "Package not found"
  end

  # def test_add_package_with_find_2
  #   ip = ImagePath.find(:first)
  #   ip.packages.find(:conditions => { :name => "banana" }) ||
  #     ip.packages.initialize(:conditions => { :name => "banana" })
  #   assert ip.save, "Image path not saved"
  #   assert ip.packages.find_by_name("banana"), "Package not found"
  # end
end
