# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
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
{ :dirname => "520images/base/lcd4-1133-01",    	:sp => "5200-01" },
{ :dirname => "520images/base/lcd4-1133-02",    	:sp => "5200-02" },
{ :dirname => "520images/base/lcd4-1133-03",    	:sp => "5200-03" },
{ :dirname => "520images/base/lcd4-1133-04",    	:sp => "5200-04" },
{ :dirname => "520images/base/lcd4-1133-06",    	:sp => "5200-06" },
{ :dirname => "520images/base/lcd4-1133-07",    	:sp => "5200-07" },
{ :dirname => "520images/base/lcd4-1133-08",    	:sp => "5200-08" },
{ :dirname => "520images/base/lcd4-1133-09",    	:sp => "5200-09" },
{ :dirname => "520images/base/lcd4-1133-11",    	:sp => "5200-10" },
{ :dirname => "520images/mls/ml01",             	:sp => "5200-01" },
{ :dirname => "520images/mls/ml02",             	:sp => "5200-02" },
{ :dirname => "520images/mls/ml03",             	:sp => "5200-03" },
{ :dirname => "520images/mls/ml04",             	:sp => "5200-04" },
{ :dirname => "520images/mls/ml05",             	:sp => "5200-05" },
{ :dirname => "520images/mls/ml06",             	:sp => "5200-06" },
{ :dirname => "520images/mls/ml07",             	:sp => "5200-07" },
{ :dirname => "520images/mls/tl08",             	:sp => "5200-08" },
{ :dirname => "520images/mls/tl09",             	:sp => "5200-09" },
{ :dirname => "520images/mls/tl10",             	:sp => "5200-10" },
{ :dirname => "520images/sp/5200-07-CSP",       	:sp => "5200-07-CSP" },
{ :dirname => "520images/sp/5200-08-01",        	:sp => "5200-08-01" },
{ :dirname => "520images/sp/5200-08-02",        	:sp => "5200-08-02" },
{ :dirname => "520images/sp/5200-08-CSP",       	:sp => "5200-08-CSP" },
{ :dirname => "520images/sp/5200-09-01",        	:sp => "5200-09-01" },
{ :dirname => "520images/sp/5200-09-02",        	:sp => "5200-09-02" },
{ :dirname => "520images/sp/5200-09-03",        	:sp => "5200-09-03" },
{ :dirname => "520images/sp/5200-09-04",        	:sp => "5200-09-04" },
{ :dirname => "520images/sp/5200-09-CSP",       	:sp => "5200-09-CSP" },
{ :dirname => "520images/sp/5200-10-01",        	:sp => "5200-10-01" },
{ :dirname => "520images/sp/5200-10-02",        	:sp => "5200-10-02" },
{ :dirname => "520images/sp/5200-10-03",        	:sp => "5200-10-03" },
{ :dirname => "520images/sp/5200-10-04",        	:sp => "5200-10-04" },
{ :dirname => "520images/sp/5200-10-05",        	:sp => "5200-10-05" },
{ :dirname => "520images/sp/5200-10-06",        	:sp => "5200-10-06" },
{ :dirname => "520images/sp/5200-10-07",        	:sp => "5200-10-07" },
{ :dirname => "520images/sp/5200-10-08",        	:sp => "5200-10-08" },
{ :dirname => "530images/aixlink",                      :sp => "sx25" },
{ :dirname => "530images/base/LCD4-7544-11",    	:sp => "5300-10-00" },
{ :dirname => "530images/base/LCD4-7544-12",    	:sp => "5300-10-01" },
{ :dirname => "530images/base/LCD4-7544-13",    	:sp => "5300-11-00" },
{ :dirname => "530images/base/LCD4-7544-15",    	:sp => "5300-11-02" },
{ :dirname => "530images/base/LCD4-7544-16",    	:sp => "5300-12-00" },
{ :dirname => "530images/base/LCD4-7544-18",    	:sp => "5300-12-02" },
{ :dirname => "530images/base/lcd4-7463-01",    	:sp => "5300-00-00" },
{ :dirname => "530images/base/lcd4-7463-02",    	:sp => "5300-00-00" },
{ :dirname => "530images/base/lcd4-7463-03",    	:sp => "5300-01-00" },
{ :dirname => "530images/base/lcd4-7463-04",    	:sp => "5300-03-00" },
{ :dirname => "530images/base/lcd4-7463-05",    	:sp => "5300-04-00" },
{ :dirname => "530images/base/lcd4-7463-06",    	:sp => "5300-05-00" },
{ :dirname => "530images/base/lcd4-7463-07",    	:sp => "5300-06-00" },
{ :dirname => "530images/base/lcd4-7463-09",    	:sp => "5300-07-00" },
{ :dirname => "530images/base/lcd4-7463-11",    	:sp => "5300-08-00" },
{ :dirname => "530images/base/lcd4-7463-13",    	:sp => "5300-09-00" },
{ :dirname => "530images/gpfs",                 	:sp => "gpfs V3.2" },
{ :dirname => "530images/mls/ml01",             	:sp => "5300-01-00" },
{ :dirname => "530images/mls/ml02",             	:sp => "5300-02-00" },
{ :dirname => "530images/mls/ml03",             	:sp => "5300-03-00" },
{ :dirname => "530images/mls/tl04",             	:sp => "5300-04-00" },
{ :dirname => "530images/mls/tl05",             	:sp => "5300-05-00" },
{ :dirname => "530images/mls/tl06",             	:sp => "5300-06-00" },
{ :dirname => "530images/mls/tl07",             	:sp => "5300-07-00" },
{ :dirname => "530images/mls/tl08",             	:sp => "5300-08-00" },
{ :dirname => "530images/mls/tl09",             	:sp => "5300-09-00" },
{ :dirname => "530images/mls/tl10",             	:sp => "5300-10-00" },
{ :dirname => "530images/mls/tl11",             	:sp => "5300-11-00" },
{ :dirname => "530images/mls/tl12",             	:sp => "5300-12-00" },
{ :dirname => "530images/sp/5300-03-CSP",       	:sp => "5300-03-CSP" },
{ :dirname => "530images/sp/5300-04-01",        	:sp => "5300-04-01" },
{ :dirname => "530images/sp/5300-04-02",        	:sp => "5300-04-02" },
{ :dirname => "530images/sp/5300-04-03",        	:sp => "5300-04-03" },
{ :dirname => "530images/sp/5300-04-CSP",       	:sp => "5300-04-CSP" },
{ :dirname => "530images/sp/5300-05-01",        	:sp => "5300-05-01" },
{ :dirname => "530images/sp/5300-05-02",        	:sp => "5300-05-02" },
{ :dirname => "530images/sp/5300-05-03",        	:sp => "5300-05-03" },
{ :dirname => "530images/sp/5300-05-04",        	:sp => "5300-05-04" },
{ :dirname => "530images/sp/5300-05-05",        	:sp => "5300-05-05" },
{ :dirname => "530images/sp/5300-05-06",        	:sp => "5300-05-06" },
{ :dirname => "530images/sp/5300-05-CSP",       	:sp => "5300-05-CSP" },
{ :dirname => "530images/sp/5300-06-01",        	:sp => "5300-06-01" },
{ :dirname => "530images/sp/5300-06-02",        	:sp => "5300-06-02" },
{ :dirname => "530images/sp/5300-06-03",        	:sp => "5300-06-03" },
{ :dirname => "530images/sp/5300-06-04",        	:sp => "5300-06-04" },
{ :dirname => "530images/sp/5300-06-05",        	:sp => "5300-06-05" },
{ :dirname => "530images/sp/5300-06-06",        	:sp => "5300-06-06" },
{ :dirname => "530images/sp/5300-06-07",        	:sp => "5300-06-07" },
{ :dirname => "530images/sp/5300-06-08",        	:sp => "5300-06-08" },
{ :dirname => "530images/sp/5300-06-09",        	:sp => "5300-06-09" },
{ :dirname => "530images/sp/5300-06-10",        	:sp => "5300-06-10" },
{ :dirname => "530images/sp/5300-06-11",        	:sp => "5300-06-11" },
{ :dirname => "530images/sp/5300-06-12",        	:sp => "5300-06-12" },
{ :dirname => "530images/sp/5300-07-01",        	:sp => "5300-07-01" },
{ :dirname => "530images/sp/5300-07-02",        	:sp => "5300-07-02" },
{ :dirname => "530images/sp/5300-07-03",        	:sp => "5300-07-03" },
{ :dirname => "530images/sp/5300-07-04",        	:sp => "5300-07-04" },
{ :dirname => "530images/sp/5300-07-05",        	:sp => "5300-07-05" },
{ :dirname => "530images/sp/5300-07-06",        	:sp => "5300-07-06" },
{ :dirname => "530images/sp/5300-07-07",        	:sp => "5300-07-07" },
{ :dirname => "530images/sp/5300-07-08",        	:sp => "5300-07-08" },
{ :dirname => "530images/sp/5300-07-09",        	:sp => "5300-07-09" },
{ :dirname => "530images/sp/5300-07-10",        	:sp => "5300-07-10" },
{ :dirname => "530images/sp/5300-08-01",        	:sp => "5300-08-01" },
{ :dirname => "530images/sp/5300-08-02",        	:sp => "5300-08-02" },
{ :dirname => "530images/sp/5300-08-03",        	:sp => "5300-08-03" },
{ :dirname => "530images/sp/5300-08-04",        	:sp => "5300-08-04" },
{ :dirname => "530images/sp/5300-08-05",        	:sp => "5300-08-05" },
{ :dirname => "530images/sp/5300-08-06",        	:sp => "5300-08-06" },
{ :dirname => "530images/sp/5300-08-07",        	:sp => "5300-08-07" },
{ :dirname => "530images/sp/5300-08-08",        	:sp => "5300-08-08" },
{ :dirname => "530images/sp/5300-08-09",        	:sp => "5300-08-09" },
{ :dirname => "530images/sp/5300-08-10",        	:sp => "5300-08-10" },
{ :dirname => "530images/sp/5300-09-01",        	:sp => "5300-09-01" },
{ :dirname => "530images/sp/5300-09-02",        	:sp => "5300-09-02" },
{ :dirname => "530images/sp/5300-09-03",        	:sp => "5300-09-03" },
{ :dirname => "530images/sp/5300-09-04",        	:sp => "5300-09-04" },
{ :dirname => "530images/sp/5300-09-05",        	:sp => "5300-09-05" },
{ :dirname => "530images/sp/5300-09-06",        	:sp => "5300-09-06" },
{ :dirname => "530images/sp/5300-09-07",        	:sp => "5300-09-07" },
{ :dirname => "530images/sp/5300-09-08",        	:sp => "5300-09-08" },
{ :dirname => "530images/sp/5300-09-09",        	:sp => "5300-09-09" },
{ :dirname => "530images/sp/5300-09-10",        	:sp => "5300-09-10" },
{ :dirname => "530images/sp/5300-10-01",        	:sp => "5300-10-01" },
{ :dirname => "530images/sp/5300-10-02",        	:sp => "5300-10-02" },
{ :dirname => "530images/sp/5300-10-03",        	:sp => "5300-10-03" },
{ :dirname => "530images/sp/5300-10-04",        	:sp => "5300-10-04" },
{ :dirname => "530images/sp/5300-10-05",        	:sp => "5300-10-05" },
{ :dirname => "530images/sp/5300-10-06",        	:sp => "5300-10-06" },
{ :dirname => "530images/sp/5300-10-07",        	:sp => "5300-10-07" },
{ :dirname => "530images/sp/5300-10-08",        	:sp => "5300-10-08" },
{ :dirname => "530images/sp/5300-10-09",        	:sp => "5300-10-09" },
{ :dirname => "530images/sp/5300-10-10",        	:sp => "5300-10-10" },
{ :dirname => "530images/sp/5300-11-01",        	:sp => "5300-11-01" },
{ :dirname => "530images/sp/5300-11-02",        	:sp => "5300-11-02" },
{ :dirname => "530images/sp/5300-11-03",        	:sp => "5300-11-03" },
{ :dirname => "530images/sp/5300-11-04",        	:sp => "5300-11-04" },
{ :dirname => "530images/sp/5300-11-05",        	:sp => "5300-11-05" },
{ :dirname => "530images/sp/5300-11-06",        	:sp => "5300-11-06" },
{ :dirname => "530images/sp/5300-11-07",        	:sp => "5300-11-07" },
{ :dirname => "530images/sp/5300-11-08",        	:sp => "5300-11-08" },
{ :dirname => "530images/sp/5300-11-09",        	:sp => "5300-11-09" },
{ :dirname => "530images/sp/5300-11-10",        	:sp => "5300-11-10" },
{ :dirname => "530images/sp/5300-12-01",        	:sp => "5300-12-01" },
{ :dirname => "530images/sp/5300-12-02",        	:sp => "5300-12-02" },
{ :dirname => "530images/sp/5300-12-03",        	:sp => "5300-12-03" },
{ :dirname => "530images/sp/5300-12-04",        	:sp => "5300-12-04" },
{ :dirname => "530images/sp/5300-12-05",        	:sp => "5300-12-05" },
{ :dirname => "530images/sp/5300-12-06",        	:sp => "5300-12-06" },
{ :dirname => "530images/sp/5300-12-07",        	:sp => "5300-12-07" },
{ :dirname => "530images/sp/5300-12-08",        	:sp => "5300-12-08" },
{ :dirname => "530images/sp/5300-12-09",        	:sp => "5300-12-09" },
{ :dirname => "530images/sp/5300-12-10",        	:sp => "5300-12-10" },
{ :dirname => "610images/base/LK4T-1479-06",    	:sp => "6100-03-00" },
{ :dirname => "610images/base/LK4T-1479-07",    	:sp => "6100-03-01" },
{ :dirname => "610images/base/LK4T-1479-08",    	:sp => "6100-04-00" },
{ :dirname => "610images/base/LK4T-1479-12",    	:sp => "6100-04-03" },
{ :dirname => "610images/base/LK4T-1479-13",    	:sp => "6100-05-00" },
{ :dirname => "610images/base/LK4T-1479-15",    	:sp => "6100-06-00" },
{ :dirname => "610images/base/LK4T-1479-16",    	:sp => "6100-06-01" },
{ :dirname => "610images/base/LK4T-1479-17",    	:sp => "6100-06-05" },
{ :dirname => "610images/base/LK4T-1479-18",            :sp => "6100-07-00" },
{ :dirname => "610images/base/LK4T-1482-04",    	:sp => "6100-02-00" },
{ :dirname => "610images/base/dec2007DVD",      	:sp => "6100-00-01" },
{ :dirname => "610images/base/lcd8-0730-00",    	:sp => "6100-00-00" },
{ :dirname => "610images/base/may2008DVD",      	:sp => "6100-01-00" },
{ :dirname => "610images/mls/tl01",             	:sp => "6100-01-00" },
{ :dirname => "610images/mls/tl02",             	:sp => "6100-02-00" },
{ :dirname => "610images/mls/tl03",             	:sp => "6100-03-00" },
{ :dirname => "610images/mls/tl04",             	:sp => "6100-04-00" },
{ :dirname => "610images/mls/tl05",             	:sp => "6100-05-00" },
{ :dirname => "610images/mls/tl06",             	:sp => "6100-06-00" },
{ :dirname => "610images/mls/tl07",             	:sp => "6100-07-00" },
{ :dirname => "610images/mls/tl08",             	:sp => "6100-08-00" },
{ :dirname => "610images/sp/6100-00-01",        	:sp => "6100-00-01" },
{ :dirname => "610images/sp/6100-00-02",        	:sp => "6100-00-02" },
{ :dirname => "610images/sp/6100-00-03",        	:sp => "6100-00-03" },
{ :dirname => "610images/sp/6100-00-04",        	:sp => "6100-00-04" },
{ :dirname => "610images/sp/6100-00-05",        	:sp => "6100-00-05" },
{ :dirname => "610images/sp/6100-00-06",        	:sp => "6100-00-06" },
{ :dirname => "610images/sp/6100-00-07",        	:sp => "6100-00-07" },
{ :dirname => "610images/sp/6100-00-08",        	:sp => "6100-00-08" },
{ :dirname => "610images/sp/6100-00-09",        	:sp => "6100-00-09" },
{ :dirname => "610images/sp/6100-00-10",        	:sp => "6100-00-10" },
{ :dirname => "610images/sp/6100-00-11",        	:sp => "6100-00-11" },
{ :dirname => "610images/sp/6100-01-01",        	:sp => "6100-01-01" },
{ :dirname => "610images/sp/6100-01-02",        	:sp => "6100-01-02" },
{ :dirname => "610images/sp/6100-01-03",        	:sp => "6100-01-03" },
{ :dirname => "610images/sp/6100-01-04",        	:sp => "6100-01-04" },
{ :dirname => "610images/sp/6100-01-05",        	:sp => "6100-01-05" },
{ :dirname => "610images/sp/6100-01-06",        	:sp => "6100-01-06" },
{ :dirname => "610images/sp/6100-01-07",        	:sp => "6100-01-07" },
{ :dirname => "610images/sp/6100-01-08",        	:sp => "6100-01-08" },
{ :dirname => "610images/sp/6100-01-09",        	:sp => "6100-01-09" },
{ :dirname => "610images/sp/6100-01-10",        	:sp => "6100-01-10" },
{ :dirname => "610images/sp/6100-01-11",        	:sp => "6100-01-11" },
{ :dirname => "610images/sp/6100-02-01",        	:sp => "6100-02-01" },
{ :dirname => "610images/sp/6100-02-02",        	:sp => "6100-02-02" },
{ :dirname => "610images/sp/6100-02-03",        	:sp => "6100-02-03" },
{ :dirname => "610images/sp/6100-02-04",        	:sp => "6100-02-04" },
{ :dirname => "610images/sp/6100-02-05",        	:sp => "6100-02-05" },
{ :dirname => "610images/sp/6100-02-06",        	:sp => "6100-02-06" },
{ :dirname => "610images/sp/6100-02-07",        	:sp => "6100-02-07" },
{ :dirname => "610images/sp/6100-02-08",        	:sp => "6100-02-08" },
{ :dirname => "610images/sp/6100-02-09",        	:sp => "6100-02-09" },
{ :dirname => "610images/sp/6100-02-10",        	:sp => "6100-02-10" },
{ :dirname => "610images/sp/6100-02-11",        	:sp => "6100-02-11" },
{ :dirname => "610images/sp/6100-03-01",        	:sp => "6100-03-01" },
{ :dirname => "610images/sp/6100-03-02",        	:sp => "6100-03-02" },
{ :dirname => "610images/sp/6100-03-03",        	:sp => "6100-03-03" },
{ :dirname => "610images/sp/6100-03-04",        	:sp => "6100-03-04" },
{ :dirname => "610images/sp/6100-03-05",        	:sp => "6100-03-05" },
{ :dirname => "610images/sp/6100-03-06",        	:sp => "6100-03-06" },
{ :dirname => "610images/sp/6100-03-07",        	:sp => "6100-03-07" },
{ :dirname => "610images/sp/6100-03-08",        	:sp => "6100-03-08" },
{ :dirname => "610images/sp/6100-03-09",        	:sp => "6100-03-09" },
{ :dirname => "610images/sp/6100-03-10",        	:sp => "6100-03-10" },
{ :dirname => "610images/sp/6100-03-11",        	:sp => "6100-03-11" },
{ :dirname => "610images/sp/6100-04-01",        	:sp => "6100-04-01" },
{ :dirname => "610images/sp/6100-04-02",        	:sp => "6100-04-02" },
{ :dirname => "610images/sp/6100-04-03",        	:sp => "6100-04-03" },
{ :dirname => "610images/sp/6100-04-04",        	:sp => "6100-04-04" },
{ :dirname => "610images/sp/6100-04-05",        	:sp => "6100-04-05" },
{ :dirname => "610images/sp/6100-04-06",        	:sp => "6100-04-06" },
{ :dirname => "610images/sp/6100-04-07",        	:sp => "6100-04-07" },
{ :dirname => "610images/sp/6100-04-08",        	:sp => "6100-04-08" },
{ :dirname => "610images/sp/6100-04-09",        	:sp => "6100-04-09" },
{ :dirname => "610images/sp/6100-04-10",        	:sp => "6100-04-10" },
{ :dirname => "610images/sp/6100-04-11",        	:sp => "6100-04-11" },
{ :dirname => "610images/sp/6100-05-01",        	:sp => "6100-05-01" },
{ :dirname => "610images/sp/6100-05-02",        	:sp => "6100-05-02" },
{ :dirname => "610images/sp/6100-05-03",        	:sp => "6100-05-03" },
{ :dirname => "610images/sp/6100-05-04",        	:sp => "6100-05-04" },
{ :dirname => "610images/sp/6100-05-05",        	:sp => "6100-05-05" },
{ :dirname => "610images/sp/6100-05-06",        	:sp => "6100-05-06" },
{ :dirname => "610images/sp/6100-05-07",        	:sp => "6100-05-07" },
{ :dirname => "610images/sp/6100-05-08",        	:sp => "6100-05-08" },
{ :dirname => "610images/sp/6100-05-09",        	:sp => "6100-05-09" },
{ :dirname => "610images/sp/6100-05-10",        	:sp => "6100-05-10" },
{ :dirname => "610images/sp/6100-05-11",        	:sp => "6100-05-11" },
{ :dirname => "610images/sp/6100-06-01",        	:sp => "6100-06-01" },
{ :dirname => "610images/sp/6100-06-02",        	:sp => "6100-06-02" },
{ :dirname => "610images/sp/6100-06-03",        	:sp => "6100-06-03" },
{ :dirname => "610images/sp/6100-06-03.1",      	:sp => "6100-06-03.1" },
{ :dirname => "610images/sp/6100-06-04",        	:sp => "6100-06-04" },
{ :dirname => "610images/sp/6100-06-05",        	:sp => "6100-06-05" },
{ :dirname => "610images/sp/6100-06-06",        	:sp => "6100-06-06" },
{ :dirname => "610images/sp/6100-06-07",        	:sp => "6100-06-07" },
{ :dirname => "610images/sp/6100-06-08",        	:sp => "6100-06-08" },
{ :dirname => "610images/sp/6100-06-09",        	:sp => "6100-06-09" },
{ :dirname => "610images/sp/6100-06-10",        	:sp => "6100-06-10" },
{ :dirname => "610images/sp/6100-06-11",        	:sp => "6100-06-11" },
{ :dirname => "610images/sp/6100-06-12",        	:sp => "6100-06-12" },
{ :dirname => "610images/sp/6100-07-01",        	:sp => "6100-07-01" },
{ :dirname => "610images/sp/6100-07-02",        	:sp => "6100-07-02" },
{ :dirname => "610images/sp/6100-07-03",        	:sp => "6100-07-03" },
{ :dirname => "610images/sp/6100-07-04",        	:sp => "6100-07-04" },
{ :dirname => "610images/sp/6100-07-05",        	:sp => "6100-07-05" },
{ :dirname => "610images/sp/6100-07-06",        	:sp => "6100-07-06" },
{ :dirname => "610images/sp/6100-07-07",        	:sp => "6100-07-07" },
{ :dirname => "610images/sp/6100-07-08",        	:sp => "6100-07-08" },
{ :dirname => "610images/sp/6100-07-09",        	:sp => "6100-07-09" },
{ :dirname => "610images/sp/6100-07-10",        	:sp => "6100-07-10" },
{ :dirname => "610images/sp/6100-07-11",        	:sp => "6100-07-11" },
{ :dirname => "610images/sp/6100-07-12",        	:sp => "6100-07-12" },
{ :dirname => "710images/base/LK4T-1710-00",    	:sp => "7100-00-00" },
{ :dirname => "710images/base/LK4T-1710-01",    	:sp => "7100-00-01" },
{ :dirname => "710images/base/LK4T-1710-02",    	:sp => "7100-00-03" },
{ :dirname => "710images/base/LK4T-1710-03",            :sp => "7100-01-00" },
{ :dirname => "710images/mls/tl01",                     :sp => "7100-01-01" },
{ :dirname => "710images/sp/7100-00-01",        	:sp => "7100-00-01" },
{ :dirname => "710images/sp/7100-00-02",        	:sp => "7100-00-02" },
{ :dirname => "710images/sp/7100-00-03",        	:sp => "7100-00-03" },
{ :dirname => "710images/sp/7100-00-04",        	:sp => "7100-00-04" },
{ :dirname => "710images/sp/7100-00-05",        	:sp => "7100-00-05" },
{ :dirname => "710images/sp/7100-00-06",        	:sp => "7100-00-06" },
{ :dirname => "710images/sp/7100-00-07",        	:sp => "7100-00-07" },
{ :dirname => "710images/sp/7100-00-08",        	:sp => "7100-00-08" },
{ :dirname => "710images/sp/7100-00-09",        	:sp => "7100-00-09" },
{ :dirname => "710images/sp/7100-00-10",        	:sp => "7100-00-10" },
{ :dirname => "710images/sp/7100-00-11",        	:sp => "7100-00-11" },
{ :dirname => "710images/sp/7100-00-12",        	:sp => "7100-00-12" },
{ :dirname => "710images/sp/7100-01-01",        	:sp => "7100-01-01" },
{ :dirname => "710images/sp/7100-01-02",        	:sp => "7100-01-02" },
{ :dirname => "710images/sp/7100-01-03",        	:sp => "7100-01-03" },
{ :dirname => "710images/sp/7100-01-04",        	:sp => "7100-01-04" },
{ :dirname => "710images/sp/7100-01-05",        	:sp => "7100-01-05" },
{ :dirname => "710images/sp/7100-01-06",        	:sp => "7100-01-06" },
{ :dirname => "710images/sp/7100-01-07",        	:sp => "7100-01-07" },
{ :dirname => "710images/sp/7100-01-08",        	:sp => "7100-01-08" },
{ :dirname => "710images/sp/7100-01-09",        	:sp => "7100-01-09" },
{ :dirname => "710images/sp/7100-01-10",        	:sp => "7100-01-10" },
{ :dirname => "710images/sp/7100-01-11",        	:sp => "7100-01-11" },
{ :dirname => "710images/sp/7100-01-12",        	:sp => "7100-01-12" },
{ :dirname => "710images/sp/7100-02-01",        	:sp => "7100-02-01" },
{ :dirname => "710images/sp/7100-02-02",        	:sp => "7100-02-02" },
{ :dirname => "710images/sp/7100-02-03",        	:sp => "7100-02-03" },
{ :dirname => "710images/sp/7100-02-04",        	:sp => "7100-02-04" },
{ :dirname => "710images/sp/7100-02-05",        	:sp => "7100-02-05" },
{ :dirname => "710images/sp/7100-02-06",        	:sp => "7100-02-06" },
{ :dirname => "710images/sp/7100-02-07",        	:sp => "7100-02-07" },
{ :dirname => "710images/sp/7100-02-08",        	:sp => "7100-02-08" },
{ :dirname => "710images/sp/7100-02-09",        	:sp => "7100-02-09" },
{ :dirname => "710images/sp/7100-02-10",        	:sp => "7100-02-10" },
{ :dirname => "710images/sp/7100-02-11",        	:sp => "7100-02-11" },
{ :dirname => "710images/sp/7100-02-12",        	:sp => "7100-02-12" },
{ :dirname => "vioimages/1.5/fixpack_10.1",		:sp => "VIOS 1.5.1.1-FP-10.1"},
{ :dirname => "vioimages/1.5/fixpack_11.1",		:sp => "VIOS 1.5.2.1-FP-11.1"},
{ :dirname => "vioimages/1.5/fp11.1_sp1",		:sp => "VIOS 1.5.2.5-FP-11.1 SP-01"},
{ :dirname => "vioimages/2.1/FP2.1.2.10",		:sp => "VIOS 2.1.2.10"},
{ :dirname => "vioimages/2.1/fixpack210",		:sp => "VIOS 2.1 FP 210"},
{ :dirname => "vioimages/2.1/fixpack21121",		:sp => "VIOS 2.1 FP 21121"},
{ :dirname => "vioimages/2.1/fixpack21210fp22.1",	:sp => "VIOS 2.1.2.10.-FP22.1"},
{ :dirname => "vioimages/2.1/fp20.1",			:sp => "VIOS 2.1.0.10-FP20.1"},
{ :dirname => "vioimages/2.1/fp21",			:sp => "VIOS 2.1.1.10-FP21"},
{ :dirname => "vioimages/2.1/fp22",			:sp => "VIOS 2.1.2.10-FP22"},
{ :dirname => "vioimages/2.1/fp23",			:sp => "VIOS 2.1.3.10-FP23"},
{ :dirname => "vioimages/2.2/FP2.2.0.12-FP-24-SP-02",	:sp => "VIOS 2.2.0.12-FP24 SP02"},
{ :dirname => "vioimages/2.2/FP2.2.0.13-FP-24-SP-03",	:sp => "VIOS 2.2.0.13-FP24 SP03"},
{ :dirname => "vioimages/2.2/FP2.2.1.1-FP-25-SP-01",    :sp => "VIOS 2.2.1-FP25 SP01" },
]

dirname_sp_mappings.each_with_index do |mapping, index|
  images = ImagePath.find(:all, :conditions => "path LIKE '#{mapping[:dirname]}/%'")
  sp = ServicePack.find_or_create_by_name(mapping[:sp])
  puts "Mapping #{index} of #{dirname_sp_mappings.length}: #{mapping[:dirname]} #{mapping[:sp]}"
  images.each do |image|
    image.package.filesets.each do |fileset|
      # We use to add only the first place we found.  (See old deleted
      # comment for more details.)  But I now have more confidence in
      # my mappings and now I always add the map.  In particular, this
      # gives the result that things shipped in VIOS are listed.  The
      # trade off is more verbosity in the output.  And there is still
      # a question of what, precisely, do the mls directories
      # represent.  Is it the SP00 level or some other level?
      ServicePackFilesetMap.find_or_create_by_service_pack_id_and_fileset_id(sp.id, fileset.id)
    end
  end
end
