
var Editor = (function() {

    var canvas,
        context,
        paint,
        hidden;

    var init = function() {
        canvas = document.getElementById('canvas');
        context = canvas.getContext('2d');

        paint = false;
        hidden = false;

        actions();
    };

    var actions = function() {
        window.onmousedown = toggle;
        window.onmousemove = draw;
        window.onmouseup = drawoff;

        $('#clear').on('click', function() {
            clear();
        });

        $('#save').on('click', function() {
            save();
        });
    };

    var toggle = function() {
        if (paint) {
            paint = false;
            document.getElementById("toggle").innerHTML = "Draw OFF";
        }
        else {
            paint = true;
            document.getElementById("toggle").innerHTML = "Draw ON";
        }
    };

    var draw = function(e) {
        var rect =  canvas.getBoundingClientRect();
        if (paint && !hidden) {
            context.fillRect(e.x - rect.left, e.y - rect.top, 50, 50);
        }
    };

    var drawoff = function() {
        paint = false;
        document.getElementById("toggle").innerHTML = "Draw OFF";
    };

    var clear = function() {
        canvas.width = 500;
        canvas.height = 500;
        context.clearRect(0, 0, 500, 500);
    };

    var save = function() {
        var digit = new Image();
        digit.src = canvas.toDataURL();

        $('#result span').html('N/A');

        digit.onload = function() {
            canvas.width = 28;
            canvas.height = 28;
            context.drawImage(digit, 4, 4, 20, 20); // add 4x4 border & shrink
            document.getElementById('img').src = canvas.toDataURL();
            //document.getElementById('canvas').style.display = 'none';
            // hidden = true;   // is canvas still editable if hidden?

            var imgData = context.getImageData(0, 0, 28, 28);
            var imgBlack = [-1];

            var counter = 0;
            for (var i = 0; i < imgData.data.length; i += 4) {
                imgBlack.push(imgData.data[i+3]);
                // if (imgData.data[i+3] === 255) {
                //     imgBlack.push(1);
                // }
                // else {
                //     imgBlack.push(0);
                // }
            }

            $.ajax({
                type: "POST",
                url: "/knn",
                // The key needs to match your method's input parameter (case-sensitive).
                data: JSON.stringify({ data: imgBlack }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(data) {
                    console.log(data.classification);
                    $('#results').append('<li>' +
                            '<img src="' + document.getElementById('img').src + '">' +
                            ' -> ' + data.classification +
                        '</li>');
                },
                failure: function(errMsg) {
                    console.log(errMsg);
                }
            });

            canvas.width = 500;
            canvas.height = 500;

        };
    };

    return {
        init: init
    };

})();

$(document).ready(function() {
    Editor.init();
});