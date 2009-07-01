#!/usr/bin/env ruby

# This is also a stop gap script.  One problem is that the service
# pack to fileset mappings may need to be deleted before the script is
# run.  There is also now way to do partial updates.

# The concept is that the path of the image implies which SP the
# fileset is in.  The mapping creates the mapping which I created
# visually.  I may need to tweak it if I  find problems.

# We then run through each image on that path and each fileset in the
# image and set a service_path_fileset_map to join the fileset with
# the service pack.

# The alternative would be to run through Betty's HTML files which I
# may look at again.  The concept of a fileset to SP mapping is
# actually pretty vague it seems.

dirname_sp_mappings = [
{ :dirname => "520images/base/lcd4-1133-01/installp/ppc", :sp => "5200-01" },
{ :dirname => "520images/mls/ml01",                       :sp => "5200-01" },
{ :dirname => "520images/base/lcd4-1133-02/installp/ppc", :sp => "5200-02" },
{ :dirname => "520images/mls/ml02",                       :sp => "5200-02" },
{ :dirname => "520images/base/lcd4-1133-03/installp/ppc", :sp => "5200-03" },
{ :dirname => "520images/mls/ml03",                       :sp => "5200-03" },
{ :dirname => "520images/base/lcd4-1133-04/installp/ppc", :sp => "5200-04" },
{ :dirname => "520images/mls/ml04",                       :sp => "5200-04" },
{ :dirname => "520images/mls/ml05",                       :sp => "5200-05" },
{ :dirname => "520images/base/lcd4-1133-06/installp/ppc", :sp => "5200-06" },
{ :dirname => "520images/mls/ml06",                       :sp => "5200-06" },
{ :dirname => "520images/base/lcd4-1133-07/installp/ppc", :sp => "5200-07" },
{ :dirname => "520images/mls/ml07",                       :sp => "5200-07" },
{ :dirname => "520images/sp/5200-07-CSP",                 :sp => "5200-07-CSP" },
{ :dirname => "520images/base/lcd4-1133-08/installp/ppc", :sp => "5200-08" },
{ :dirname => "520images/mls/tl08",                       :sp => "5200-08" },
{ :dirname => "520images/sp/5200-08-01",                  :sp => "5200-08-01" },
{ :dirname => "520images/sp/5200-08-02",                  :sp => "5200-08-02" },
{ :dirname => "520images/sp/5200-08-CSP",                 :sp => "5200-08-CSP" },
{ :dirname => "520images/base/lcd4-1133-09/installp/ppc", :sp => "5200-09" },
{ :dirname => "520images/mls/tl09",                       :sp => "5200-09" },
{ :dirname => "520images/sp/5200-09-01",                  :sp => "5200-09-01" },
{ :dirname => "520images/sp/5200-09-02",                  :sp => "5200-09-02" },
{ :dirname => "520images/sp/5200-09-03",                  :sp => "5200-09-03" },
{ :dirname => "520images/sp/5200-09-04",                  :sp => "5200-09-04" },
{ :dirname => "520images/sp/5200-09-CSP",                 :sp => "5200-09-CSP" },
{ :dirname => "520images/mls/tl10",                       :sp => "5200-10" },
{ :dirname => "520images/sp/5200-10-01",                  :sp => "5200-10-01" },
{ :dirname => "520images/sp/5200-10-02",                  :sp => "5200-10-02" },
{ :dirname => "520images/sp/5200-10-03",                  :sp => "5200-10-03" },
{ :dirname => "520images/sp/5200-10-04",                  :sp => "5200-10-04" },
{ :dirname => "520images/sp/5200-10-05",                  :sp => "5200-10-05" },
{ :dirname => "520images/sp/5200-10-06",                  :sp => "5200-10-06" },
{ :dirname => "520images/sp/5200-10-07",                  :sp => "5200-10-07" },
{ :dirname => "520images/base/lcd4-1133-11/installp/ppc", :sp => "5200-11" },
{ :dirname => "530images/base/lcd4-7463-01/installp/ppc", :sp => "5300-01" },
{ :dirname => "530images/mls/ml01",                       :sp => "5300-01" },
{ :dirname => "530images/base/lcd4-7463-02/installp/ppc", :sp => "5300-02" },
{ :dirname => "530images/mls/ml02",                       :sp => "5300-02" },
{ :dirname => "530images/base/lcd4-7463-03/installp/ppc", :sp => "5300-03" },
{ :dirname => "530images/mls/ml03",                       :sp => "5300-03" },
{ :dirname => "530images/sp/5300-03-CSP",                 :sp => "5300-03-CSP" },
{ :dirname => "530images/base/lcd4-7463-04/installp/ppc", :sp => "5300-04" },
{ :dirname => "530images/mls/tl04",                       :sp => "5300-04" },
{ :dirname => "530images/sp/5300-04-01",                  :sp => "5300-04-01" },
{ :dirname => "530images/sp/5300-04-02",                  :sp => "5300-04-02" },
{ :dirname => "530images/sp/5300-04-03",                  :sp => "5300-04-03" },
{ :dirname => "530images/sp/5300-04-CSP",                 :sp => "5300-04-CSP" },
{ :dirname => "530images/base/lcd4-7463-05/installp/ppc", :sp => "5300-05" },
{ :dirname => "530images/mls/tl05",                       :sp => "5300-05" },
{ :dirname => "530images/sp/5300-05-01",                  :sp => "5300-05-01" },
{ :dirname => "530images/sp/5300-05-02",                  :sp => "5300-05-02" },
{ :dirname => "530images/sp/5300-05-03",                  :sp => "5300-05-03" },
{ :dirname => "530images/sp/5300-05-04",                  :sp => "5300-05-04" },
{ :dirname => "530images/sp/5300-05-05",                  :sp => "5300-05-05" },
{ :dirname => "530images/sp/5300-05-06",                  :sp => "5300-05-06" },
{ :dirname => "530images/sp/5300-05-CSP",                 :sp => "5300-05-CSP" },
{ :dirname => "530images/base/lcd4-7463-06/installp/ppc", :sp => "5300-06" },
{ :dirname => "530images/mls/tl06",                       :sp => "5300-06" },
{ :dirname => "530images/sp/5300-06-01",                  :sp => "5300-06-01" },
{ :dirname => "530images/sp/5300-06-02",                  :sp => "5300-06-02" },
{ :dirname => "530images/sp/5300-06-03",                  :sp => "5300-06-03" },
{ :dirname => "530images/sp/5300-06-04",                  :sp => "5300-06-04" },
{ :dirname => "530images/sp/5300-06-05",                  :sp => "5300-06-05" },
{ :dirname => "530images/sp/5300-06-06",                  :sp => "5300-06-06" },
{ :dirname => "530images/sp/5300-06-07",                  :sp => "5300-06-07" },
{ :dirname => "530images/sp/5300-06-08",                  :sp => "5300-06-08" },
{ :dirname => "530images/sp/5300-06-09",                  :sp => "5300-06-09" },
{ :dirname => "530images/sp/5300-06-10",                  :sp => "5300-06-10" },
{ :dirname => "530images/sp/5300-06-11",                  :sp => "5300-06-11" },
{ :dirname => "530images/base/lcd4-7463-07/installp/ppc", :sp => "5300-07" },
{ :dirname => "530images/mls/tl07",                       :sp => "5300-07" },
{ :dirname => "530images/sp/5300-07-01",                  :sp => "5300-07-01" },
{ :dirname => "530images/sp/5300-07-02",                  :sp => "5300-07-02" },
{ :dirname => "530images/sp/5300-07-03",                  :sp => "5300-07-03" },
{ :dirname => "530images/sp/5300-07-04",                  :sp => "5300-07-04" },
{ :dirname => "530images/sp/5300-07-05",                  :sp => "5300-07-05" },
{ :dirname => "530images/sp/5300-07-06",                  :sp => "5300-07-06" },
{ :dirname => "530images/sp/5300-07-07",                  :sp => "5300-07-07" },
{ :dirname => "530images/sp/5300-07-08",                  :sp => "5300-07-08" },
{ :dirname => "530images/mls/tl08",                       :sp => "5300-08" },
{ :dirname => "530images/sp/5300-08-01",                  :sp => "5300-08-01" },
{ :dirname => "530images/sp/5300-08-02",                  :sp => "5300-08-02" },
{ :dirname => "530images/sp/5300-08-03",                  :sp => "5300-08-03" },
{ :dirname => "530images/sp/5300-08-04",                  :sp => "5300-08-04" },
{ :dirname => "530images/sp/5300-08-05",                  :sp => "5300-08-05" },
{ :dirname => "530images/sp/5300-08-06",                  :sp => "5300-08-06" },
{ :dirname => "530images/base/lcd4-7463-09/installp/ppc", :sp => "5300-09" },
{ :dirname => "530images/mls/tl09",                       :sp => "5300-09" },
{ :dirname => "530images/sp/5300-09-01",                  :sp => "5300-09-01" },
{ :dirname => "530images/sp/5300-09-02",                  :sp => "5300-09-02" },
{ :dirname => "530images/sp/5300-09-03",                  :sp => "5300-09-03" },
{ :dirname => "530images/mls/tl10",                       :sp => "5300-10" },
{ :dirname => "530images/sp/5300-10-01",                  :sp => "5300-10-01" },
{ :dirname => "530images/base/LCD4-7544-11/installp/ppc", :sp => "5300-11" },
{ :dirname => "530images/base/lcd4-7463-11/installp/ppc", :sp => "5300-11" },
{ :dirname => "530images/base/LCD4-7544-12/installp/ppc", :sp => "5300-12" },
{ :dirname => "530images/base/lcd4-7463-13/installp/ppc", :sp => "5300-13" },
{ :dirname => "610images/base/lcd8-0730-00",              :sp => "6100-00-00" },
{ :dirname => "610images/base/dec2007DVD/installp/ppc",   :sp => "6100-00-01" },
{ :dirname => "610images/sp/6100-00-01",                  :sp => "6100-00-01" },
{ :dirname => "610images/sp/6100-00-02",                  :sp => "6100-00-02" },
{ :dirname => "610images/sp/6100-00-03",                  :sp => "6100-00-03" },
{ :dirname => "610images/sp/6100-00-04",                  :sp => "6100-00-04" },
{ :dirname => "610images/sp/6100-00-05",                  :sp => "6100-00-05" },
{ :dirname => "610images/sp/6100-00-06",                  :sp => "6100-00-06" },
{ :dirname => "610images/sp/6100-00-07",                  :sp => "6100-00-07" },
{ :dirname => "610images/sp/6100-00-08",                  :sp => "6100-00-08" },
{ :dirname => "610images/sp/6100-00-09",                  :sp => "6100-00-09" },
{ :dirname => "610images/mls/tl01",                       :sp => "6100-01" },
{ :dirname => "610images/base/may2008DVD/installp/ppc",   :sp => "6100-01-00" },
{ :dirname => "610images/sp/6100-01-01",                  :sp => "6100-01-01" },
{ :dirname => "610images/sp/6100-01-02",                  :sp => "6100-01-02" },
{ :dirname => "610images/sp/6100-01-03",                  :sp => "6100-01-03" },
{ :dirname => "610images/sp/6100-01-04",                  :sp => "6100-01-04" },
{ :dirname => "610images/sp/6100-01-05",                  :sp => "6100-01-05" },
{ :dirname => "610images/mls/tl02",                       :sp => "6100-02" },
{ :dirname => "610images/base/LK4T-1482-04/installp/ppc", :sp => "6100-02-00" },
{ :dirname => "610images/sp/6100-02-01",                  :sp => "6100-02-01" },
{ :dirname => "610images/sp/6100-02-02",                  :sp => "6100-02-02" },
{ :dirname => "610images/sp/6100-02-03",                  :sp => "6100-02-03" },
{ :dirname => "610images/sp/6100-02-04",                  :sp => "6100-02-04" },
{ :dirname => "610images/mls/tl03",                       :sp => "6100-03" },
{ :dirname => "610images/base/LK4T-1479-06/installp/ppc", :sp => "6100-03-00" },
{ :dirname => "610images/base/LK4T-1479-07/installp/ppc", :sp => "6100-03-01" },
{ :dirname => "610images/sp/6100-03-01",                  :sp => "6100-03-01" }
]

dirname_sp_mappings.each_with_index do |mapping, index|
  images = ImagePath.find(:all, :conditions => "path LIKE '#{mapping[:dirname]}/%'")
  sp = ServicePack.find_or_create_by_name(mapping[:sp])
  puts "Mapping #{index}: #{mapping[:dirname]} #{mapping[:sp]}"
  images.each do |image|
    image.package.filesets.each do |fileset|
      ServicePackFilesetMap.find_or_create_by_service_pack_id_and_fileset_id(sp.id, fileset.id)
    end
  end
end
