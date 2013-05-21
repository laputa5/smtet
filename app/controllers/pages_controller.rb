# -*- coding: utf-8 -*-
class PagesController < ApplicationController
  before_filter :prepare_menu_path_title_lookup

  def welcome
    render "pages/welcome", :layout => "welcome"
    
  end

  def show
    view_name = "pages/#{params[:path]}"
    if template_exists?(view_name)
      render view_name
    else
      render "pages/default"
    end
      
  end


  protected
  def prepare_menu_path_title_lookup
    @menu_path_title_lookup = {
      "home" => "首頁",
      "about" => "公司简介",
      "farm" => "生態示範農場",
      "consult" => "投资咨询",
      "lease" => "工厂租赁",
      "registry" => "外资注册",
      "personnel" => "人才信息",
      "contact" => "聯絡我們" }
  end
end
