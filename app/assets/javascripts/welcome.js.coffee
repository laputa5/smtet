# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->
  setTitleFonts()
  positionTitles()
  $(".tile").click(tileClicked)
  $(".tile").each -> 
    storeDataBeforeExpand($(this))
  
setTitleFonts = ->
  $(".title").each ->
    $(this).css "font-size", 15

positionTitles = ->
  $(".title").each -> 
    $(this).css "top", "10px"
    $(this).css "left", "10px"
     
 
tileClicked = ->
  $(".tile").not($(this)).filter(":animated").click()
  $(this).off("click")
  $(this).css("z-index", 5)
  expandTile($(this))

findTile = (contentTileJObject) ->
  tileNum = findTileNumForTile(contentTileJObject)
  tileClassString =".tile.tile" + tileNum
  contentTileJObject.parent().find(tileClassString)


findTileNumForTile = (tileJObject) ->
  classList = tileJObject.attr('class').split(/\s+/)
  tileNum = null
  $.each classList, (index, item) ->
    pat = /tile(\d{1,2})/
    matched = pat.exec(item)
    tileNum = matched[1] if matched?
  tileNum
 
expandTile = (tileJObject) ->
  tileJObject.animate 
    top:'0px'
    left:'0px'
    height:tileJObject.parent().css('height')
    width:tileJObject.parent().css('width')
    'background-size':'20%'
    'background-position-x':'10%'
    'background-position-y':'10%'
  , 300
  tileJObject.find(".title").animate 
    top:'50px'
    left:'50px'
    'font-size':"40px"
  , 300
  tileJObject.click(shrinkContentTile)

shrinkContentTile = ->
  $(this).stop()
  $(this).off("click")
  $(this).animate 
    top:$(this).data('top')
    left:$(this).data('left')
    height:$(this).data('height')
    width:$(this).data('width')
    'background-size':$(this).data('background-size')
    'background-position-x':$(this).data('background-position-x')
    'background-position-y':$(this).data('background-position-y')
  , 300, ->
    $(this).css("z-index", 0)
    $(this).on("click", tileClicked)
  $(this).find(".title").animate 
    top:$(this).data('titleTop')
    left:$(this).data('titleLeft')
    'font-size':$(this).data('titleFontSize')
  , 300

 
storeDataBeforeExpand = (tileJObject) ->
  tileJObject.data("top", tileJObject.css("top"))
  tileJObject.data("left", tileJObject.css("left"))
  tileJObject.data("height", tileJObject.height())
  tileJObject.data("width", tileJObject.width())
  tileJObject.data("background-size", tileJObject.css("background-size"))
  tileJObject.data("background-position-x", tileJObject.css("background-position-x"))
  tileJObject.data("background-position-y", tileJObject.css("background-position-y"))
  tileJObject.data("titleTop", tileJObject.find(".title").position().top)
  tileJObject.data("titleLeft", tileJObject.find(".title").position().left)
  tileJObject.data("titleFontSize", tileJObject.find(".title").css("font-size"))




    
