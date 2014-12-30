module = angular.module 'app', []


module.controller 'main',
  ['$rootScope', '$scope','$http', '$location', '$timeout', '$log'
   (($rootScope, $scope, $http, $location, $timeout, $log) ->




    return)]

module.controller 'picturesGallery',
  ['$rootScope', '$document', '$scope','$http', '$location', '$timeout', '$log'
   (($rootScope, $document, $scope, $http, $location, $timeout, $log) ->
    mainAreaWidth = -> $('.main-area').width()

    # Arrange images in grid
    arrangePictures=(->
      $('.gallery-grid').css('height', $(window).height()*0.85)

      windowWidth =  $(window).width()
      columnNums = switch
        when windowWidth >= 750 && windowWidth < 1000 then 3
        when windowWidth >= 500 && windowWidth <750 then 2
        when windowWidth < 500 then 1
        else 4

      $('.gallery-grid > li').each((index, el)->
        picWidth = mainAreaWidth()/columnNums - columnNums*10
        row = Math.floor index/columnNums
        col = index - row*columnNums
        if(index > columnNums - 1)
          upperEl = $('.gallery-grid > li').eq(index - columnNums)
          upperElBottom = upperEl.position().top + upperEl.height()
        else
          upperElBottom = -20
        $(el).width(picWidth).css('left', (picWidth + 20)*col).css('top', upperElBottom + 20)

        return)
      return)

    imgLoad = imagesLoaded($('.gallery-grid'))
    imgLoad.on 'always', -> arrangePictures()   # wait images loaded

    $(window).resize ->
      arrangePictures()

    pictureFullSize =(()->
      windowWidth =  $(window).width()
      windowHeight =  $(window).height()
      $('.picture-wrapper').css('width', windowWidth).css("height", windowHeight)
      $('.picture').css('max-width', windowWidth*0.9).css('max-height', windowHeight*0.9).css('width', 'auto').css("height", "auto")
#      if(windowHeight>=windowWidth)
#      else
#        $('.picture-wrapper').css('height', windowHeight).css("width", "auto")
#        $('.picture').css('height', '100%').css("width", "auto")

      return)

    $scope.galleryImg =
      currentImgFileName: null
      currentImgIndex: null
      show: ((index)->
        @isBackdropShow = true
        @currentImgFileName = picturesArray[index].fileName
        @currentImgIndex = +index
        if ($scope.$root.$$phase != '$apply' && $scope.$root.$$phase != '$digest')
          $scope.$apply()
        pictureFullSize()
        return)
      close: (->
        @isBackdropShow = false
        @currentImgFileName = null
        @currentImgIndex = null
        if ($scope.$root.$$phase != '$apply' && $scope.$root.$$phase != '$digest')
          $scope.$apply()
        return)
      isNextLeft: (-> return @currentImgIndex != 0)
      isNextRight: (-> return @currentImgIndex != picturesArray.length-1)
      nextLeft: (->
        @currentImgIndex--
        @currentImgFileName = picturesArray[@currentImgIndex].fileName
        pictureFullSize()
        if ($scope.$root.$$phase != '$apply' && $scope.$root.$$phase != '$digest')
          $scope.$apply()
        return)
      nextRight: (->
        @currentImgIndex++
        @currentImgFileName = picturesArray[@currentImgIndex].fileName
        pictureFullSize()
        if ($scope.$root.$$phase != '$apply' && $scope.$root.$$phase != '$digest')
          $scope.$apply()
        return)
      isBackdropShow: false

    $document.keydown((e)->
      if($scope.galleryImg.currentImgIndex!=null)
        if(e.keyCode==37 && $scope.galleryImg.isNextLeft())
          $scope.galleryImg.nextLeft()
        if(e.keyCode==39 && $scope.galleryImg.isNextRight())
          $scope.galleryImg.nextRight()
        if(e.keyCode==27)
          $scope.galleryImg.close()
      console.log e.keyCode
      return
    )




    return)]








