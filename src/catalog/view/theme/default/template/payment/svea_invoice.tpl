<div class="buttons">

    <div class="right">

        <?php echo $this->language->get("text_private_or_company")?>: <select id="svea_invoice_company" name="svea_invoice_company">
            <option value="true"><?php echo $this->language->get("text_company")?></option>
            <option value="false" selected="selected"><?php echo $this->language->get("text_private")?></option>
        </select><br /><br />

        <?php if($countryCode == "SE" || $countryCode == "DK" || $countryCode == "NO" || $countryCode == "FI"){?>
        <span id="svea_private_text"><?php echo $this->language->get("text_ssn")?></span>
        <span id="svea_business_text" style="display:none;"><?php echo $this->language->get("text_vat_no")?></span>
        : <input type="text" id="ssn" name="ssn" /><br /><br />
        <?php }?>

        <?php if($countryCode == "SE" || $countryCode == "DK" || $countryCode == "NO"){?>
        <a id="getSSN" class="button"><span><?php echo $this->language->get("text_get_address")?></span></a>
        <?php }?>


    </div>
    <br />

    <div id="svea_invoice_err" class="right" style="color:red; clear:both; margin-bottom:20px"></div><br />


    <?php if($countryCode == "SE" || $countryCode == "DK" || $countryCode == "NO" || $countryCode == "FI"){ ?>
    <div id="svea_invoice_div" class="right" style="clear:both;">
        <br />
        <?php echo $this->language->get("text_invoice_address")?>:<br />
        <select name="svea_invoice_address" id="svea_invoice_address">
        </select>

    <?php }else{

        //Days, to 31
        $days = "";
        $zero = "";
        for($d = 1; $d <= 31; $d++){

            $val = $d;
            if($d < 10)
                $val = "$d";

            $days .= "<option value='$val'>$d</option>";
        }
        $birthDay = "<select name='birthDay' id='birthDay'>$days</select>";


        //Months to 12
        $months = "";
        for($m = 1; $m <= 12; $m++){
            $val = $m;
            if($m < 10)
                $val = "$m";

            $months .= "<option value='$val'>$m</option>";
        }
        $birthMonth = "<select name='birthMonth' id='birthMonth'>$months</select>";

        //Years from 1913 to 1996
        $years = '';
        for($y = 1913; $y <= 1996; $y++){
            $years .= "<option value='$y'>$y</option>";
        }
        $birthYear = "<select name='birthYear' id='birthYear'>$years</select>";
        ?>

        <div class="right" style="clear:both;">
         <span id="sveaBirthDateCont"><?php echo $this->language->get("text_birthdate")?>: <?php  echo "$birthDay $birthMonth $birthYear"; ?><br /><br />
        <?php if($countryCode == "NL"){ ?>
           <?php echo $this->language->get("text_initials")?>: <input type="text" id="initials" name="initials" />
        <?php }?>
         </span>
         <span id="sveaVatNoCont"><?php echo $this->language->get("text_vat_no")?>: <input type="text" id="vatno" name="vatno" /><br /><br /></span>

         <?php } ?>
     </div>

    <div class="right" style="clear:both;"><br /><br /><a id="checkout" class="button"><span><?php echo $button_confirm; ?></span></a></div><br />


    <br />

</div>
<style>
#SveaAddressDiv{margin:10px 0;}
</style>
<script type="text/javascript"><!--


<?php if($countryCode == "SE" || $countryCode == "DK" || $countryCode == "NO"){?>
$("a#checkout").hide();
<?php }?>

$('#svea_invoice_div').hide();
$('#sveaVatNoCont').hide();

//Selection of business or private
$("#svea_invoice_company").change(function(){

    if ($(this).val() == "true"){
        $('#sveaVatNoCont').show();
        $('#sveaBirthDateCont').hide();

        $('#svea_private_text').hide();
        $('#svea_business_text').show();
    }else{
        $('#sveaVatNoCont').hide();
        $('#sveaBirthDateCont').show();

        $('#svea_private_text').show();
        $('#svea_business_text').hide();
    }

});

//Loader
var sveaLoading = '<img src="catalog/view/theme/default/image/loading.gif" id="sveaLoading" />';

$('a#checkout').click(function() {
    //Show loader
    $(this).parent().after().append(sveaLoading);

    var company = $("#svea_invoice_company").val();
    var ssnNo = $('#ssn').val();
    var adressSelector = $('#svea_invoice_address').val();
    var Initials = $("#initials").val();
    var birthDay = $("#birthDay").val();
    var birthMonth = $("#birthMonth").val();
    var birthYear = $("#birthYear").val();
    var vatNo = $('#vatno').val();

	$.ajax({
		type: 'GET',
        data: {ssn: ssnNo, company: company, addSel: adressSelector, initials: Initials, birthDay: birthDay, birthMonth: birthMonth, birthYear: birthYear, vatno: vatNo },
		url: 'index.php?route=payment/svea_invoice/confirm',
		success: function(data) {

            var json = JSON.parse(data);
            if(json.success){
                location = '<?php echo $continue; ?>';
            }else{
                $("#svea_invoice_err").show().append('<br>'+json.error);
            }

            $('#sveaLoading').remove();
		}
	});
});


//Get address
$('#getSSN').click(function() {
    //Show loader
    $(this).parent().after().append(sveaLoading);

    var company = $("#svea_invoice_company").val();
    var ssnNo = $('#ssn').val();
    $("#svea_invoice_err").empty();
    $("#svea_invoice_address").empty();
    $("#svea_invoice_div").hide();

    if(ssnNo == ''){
        alert('Vänligen fyll i personnr');
    }else{

    	$.ajax({
    		type: 'GET',
    		url: 'index.php?route=payment/svea_invoice/getAddress',
            data: {ssn: ssnNo, company: company},
    		success: function(msg) {
                var json = JSON.parse(msg);

                //on error
                if (json.error){

                    $("#svea_invoice_err").show().append('<br>'+json.error);

                }else{

                    if (json.length > 1){
                        $("#SveaAddressDiv").empty();
                        $.each(json,function(key,value){
                            $("#svea_invoice_address").append('<option value="'+value.addressSelector+'">'+value.fullName+' '+value.street+' '+value.zipCode+' '+value.locality+'</option>');
                        });

                        $("#svea_invoice_address").show();

                    }else{
                        $("#svea_invoice_address").hide();
                        $("#svea_invoice_div").append('<div id="SveaAddressDiv"><strong>'+json[0].fullName+'</strong><br> '+json[0].street+' <br>'+json[0].zipCode+' '+json[0].locality+'</div>');
                    }

                    $("#svea_invoice_div").show();
                    $("#svea_invoice_err").hide();
                    $("a#checkout").show();

                }

                $('#sveaLoading').remove();

    		}
    	});
    }
});
//--></script>
