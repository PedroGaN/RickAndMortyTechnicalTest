# ignore all warnings from all pods
inhibit_all_warnings!

use_frameworks!
platform :ios, '13.0'

def project_pods
  pod 'Alamofire'
  pod 'SwiftLint'
end

target 'BasicTemplate' do

  project_pods

  target 'BasicTemplateTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'BasicTemplateUITests' do
    # Pods for testing
  end

end

target 'Domain' do

  project_pods

  target 'DomainTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'Data' do

  project_pods

  target 'DataTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
