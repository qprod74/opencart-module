<?php echo $header; ?>

<link href="catalog/view/theme/default/stylesheet/svea/sco.css" rel="stylesheet">
<script src="catalog/view/theme/default/javascript/svea/sco.js"></script>

<div class="container" id="container">

    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>

    <section class="checkout-page-container">

        <div class="sco-main-content">
            <div class="row">
                <div class="col-12" style="width: 100%;">
                    <section class="sco-right-column">
                        <div id="sco-snippet-section">
                            <?php echo $snippet; ?>
                        </div>

                        <div class="buttons">
                            <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
                        </div>
                    </section>
                </div>
            </div>
        </div>

    </section>


</div>

<?php echo $footer; ?>