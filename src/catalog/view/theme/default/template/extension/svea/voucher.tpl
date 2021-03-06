<?php if ($voucher) { ?>
	<!-- Voucher successful - start -->
	<div class="input-group">
		<span class="sco-input-label"><?php echo $item_voucher; ?></span>
		<div id="sco-voucher-input" class="form-control sco-input" style="line-height: 35px;">
			<?php echo $voucher['code']; ?>
		</div>
		<span class="input-group-btn">
					<button class="btn btn-danger sco-btn-danger" id="sco-voucher-remove">
						<i id="sco-voucher-button-icon" class="glyphicon glyphicon-trash"></i>
					</button>
				</span>
	</div>
	<script>
	  $('#voucher-toggle-btn').addClass('used');
	  $('#sco-voucher-input').addClass('sco-input-applied');
	</script>
	<!-- Voucher successful - end -->
	<?php } else { ?>
	<!-- Voucher unsuccessfully - start -->
	<div class="input-group">
		<input type="text"  placeholder="<?php echo $item_voucher?>" class="form-control sco-input" name="voucher" />
		<span class="input-group-btn">
					<button class="btn sco-primary-btn" id="sco-voucher-add" type="button">
						<i id="sco-voucher-button-icon" class="glyphicon glyphicon-plus"></i>
					</button>
				</span>
	</div>
	<script>
	  $('#voucher-toggle-btn').removeClass('used');
	  $('#sco-voucher-input').removeClass('sco-input-applied');
	</script>
	<!-- Voucher unsuccessfully - end -->
<?php } ?>