//郵便番号で住所検索
$(function(){
    $('#button2').click(function() {
        //多重送信防止
        var button = $(this);
        button.attr("disabled", true);
        //　JSON形式に変形
        var sed_data ={
            Postcode: Number($("#postcode").val()),
            }
        console.log("コンソール");
        console.log(sed_data)
        $.ajax({
            type:"post",                    //POST形式
            url:"http://127.0.0.1/webapp/api_py/inquirypostcode", //URL
            data:JSON.stringify(sed_data),      //送信JSONデータ
            contentType: 'application/json',//リクエストタイプ
            dataType: "json",               //受信データ
            // API送受信完了
            success: function(rcv_data){
                console.log(rcv_data);
                if ( rcv_data.result == 0) {
                    adress = rcv_data.prefectural + rcv_data.municipality + rcv_data.town
                    $("#message2").text(adress)
                }
                else $("#message2").text("サポートへご連絡ください。")
            return;
            },
            error: function(rcv_data){
                console.log(rcv_data);
                $("#message2").text("サポートへご連絡ください。")
                return;
            },
            complete: function(){
                button.attr("disabled", false);
            }
        })
        })
        });
