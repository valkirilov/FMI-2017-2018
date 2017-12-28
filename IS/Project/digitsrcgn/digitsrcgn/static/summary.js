
var Summary = (function() {

    var init = function() {
        getKNN();
    };

    var getKNN = function() {
        $.get('/knn', function(response) {
            console.log(response);

            $('#pane-' + response.algorithm).find('.accuracy span').text(response.accuracy + '%');
            $('#pane-' + response.algorithm).find('.training-data').text(response.train_data_length);
            $('#pane-' + response.algorithm).find('.test-data').text(response.test_data_length);
            $('#pane-' + response.algorithm).find('.successfully-classified-data').text(response.successfully_classified);
        }, 'json');
    };

    return {
        init: init
    };

})();

$(document).ready(function() {
    Summary.init();
});