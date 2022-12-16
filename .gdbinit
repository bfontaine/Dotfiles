# https://aurelien-riv.github.io/php/2019/12/07/which-function-php-executing.html
define phpbt
  set $ed=executor_globals.current_execute_data
  while $ed
    set $scope=((zend_execute_data *)$ed)->func.common.scope
    set $funcname=((zend_execute_data *)$ed)->func.common.function_name.val
    if $scope
      print {(char*)$scope.name.val, (char*)$funcname}
    else
      print {(char*)$funcname}
    end
    set $ed = ((zend_execute_data *)$ed)->prev_execute_data
  end
end
