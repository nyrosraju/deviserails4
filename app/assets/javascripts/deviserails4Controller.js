// define controller for wizard

var deviserails4Controller = ['$scope', '$q', '$timeout',
                              
function ($scope, $q, $timeout,User) {

  
    $scope.init = function(user)
  {
    $scope.user = user ;
  }
  

   $scope.saveState = function(user) {
    var deferred = $q.defer();

    $timeout(function() {
      deferred.resolve();
    }, 5000);
     console.log( $scope.user)
 
    return deferred.promise;
  }; 
 

  $scope.completeWizard = function(user) {
      console.log( $scope.user)
    alert('Completed!');
       		       $.ajax({
			       url: '/profiles/profile_update',
			       data: {val:  $scope.user},
			       type: 'get',
			       dataType: 'script',
			       complete: function(res){
				
				}
			     });  
     //window.location.reload(true);
  }
}];