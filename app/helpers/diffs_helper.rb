# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
module DiffsHelper
  def put_file_div(lines, which, params)
    render(:partial => "put_file_div",
           :locals => {
             :lines => lines,
             :which => which,
             :title => "#{params[:release]} #{params[:path]} #{params[:version]}"
           })

  end

  def get_id_class_line(line_id, type, which, last_num, num)
    if type == "match"
      css_id = ""
      css_class = "class=\"code\""
    else
      if last_num != num
        css_id = "id=\"diff-#{which}-#{num}\""
        last_num = num
      else
        css_id = ""
      end
      css_class = "class=\"code #{type.gsub(/_/, '-')}\""
    end
    # line = line_id.nil? ? " " : StringTable.lookup(line_id).chomp
    line = line_id.nil? ? " " : line_id.chomp
    return css_id, css_class, line
  end
end
