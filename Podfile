platform :ios, '9.0'

#--------------------------------------

def reactive_pods
  pod 'RxSwift'
  pod 'RxCocoa'
end

#--------------------------------------

def network_pods
  pod 'Alamofire'
end

#--------------------------------------

def dependency_pods
  pod 'Swinject'
end

#--------------------------------------

def imageDownloader_pods
  pod 'Kingfisher'
end

#--------------------------------------

target 'Nearby' do
  use_frameworks!
  
  reactive_pods
  network_pods
  dependency_pods
  imageDownloader_pods
  
  target 'NearbyTests' do
    reactive_pods
  end

end

#--------------------------------------
