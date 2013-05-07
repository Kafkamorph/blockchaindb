<?php

// This file extracts all data from the blockchain
// and stores it in a mysql_database

// Configuration
$start = 1;
$destination = 10000;

$tool_name = "bitcoind";

/* Sample Query:
INSERT INTO `blockchain`.`blocks` (`id`, `hash`, `confirmations`, `size`, `height`, `version`, `merkleroot`, `time`, `nonce`, `bits`, `difficulty`, `previousblockhash`, `nextblockhash`) 
VALUES (NULL, '00000000839a8e6886ab5951d76f411475428afc90947ee320161bbf18eb6048', '234840', '215', '1', '1', '0e3e2357e806b6cdb1f70b54c3a3a17b6714ee1f0e68bebb44a74b1efd512098', 
'1231469665', '2573394689', '1d00ffff', '1.00000000', '000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f', '000000006a625f06636b8bb6ac7b960a8d03705d1ace08b1a19da3fdcc99ddbd');

And:

INSERT INTO `blockchain`.`tx` (`id`, `tx_ref`, `tx`) VALUES (NULL, '1', '0e3e2357e806b6cdb1f70b54c3a3a17b6714ee1f0e68bebb44a74b1efd512098');
*/
function process_query($decoded_json) {
	$hash = $decoded_json["hash"];
	$confirmations = $decoded_json["confirmations"];
	$size = $decoded_json["size"];
	$height = $decoded_json["height"];
	$version = $decoded_json["version"];
	$merkleroot = $decoded_json["merkleroot"];
	$tx = $decoded_json["tx"];
	$time = $decoded_json["time"];
	$nonce = $decoded_json["nonce"];
	$bits = $decoded_json["bits"];
	$difficulty = $decoded_json["difficulty"];
	$previousblockhash = $decoded_json["previousblockhash"];
	$nextblockhash = $decoded_json["nextblockhash"];
	
	
	$sql  = "INSERT INTO `blockchain`.`blocks` (`id`, `hash`, `confirmations`, `size`, `height`, `version`, `merkleroot`, `time`, `nonce`, `bits`, `difficulty`, `previousblockhash`, `nextblockhash`) ";
	$sql .= "VALUES (NULL, '$hash', '$confirmations', '$size', '$height', '$version', '$merkleroot', '$time', '$nonce', '$bits', '$difficulty', '$previousblockhash', '$nextblockhash');";
    
	mysql_query($sql);
	echo mysql_error();
	
	foreach ($tx as $txn) {
		$sql2 = "INSERT INTO `blockchain`.`tx` (`id`, `height`, `tx`) VALUES (NULL, '$height', '$txn');";
		mysql_query($sql2);
		echo mysql_error();
	        
    	        process_transaction($txn);      	
	}
}

function process_transaction($tx) {
    global $info;
    global $tool_name;
    
    $info++;
    
    $rawtransaction = shell_exec("$tool_name getrawtransaction $tx 1");
    $decoded = json_decode($rawtransaction, true); 
    
    
    
    
    // tx_detail
    $hex = $decoded["hex"];
    $txn = $decoded["txid"];
    $version = $decoded["version"];
    $locktime = $decoded["locktime"];
    $block = $decoded["blockhash"];
    $confirmations = $decoded["confirmations"];
    $time = $decoded["time"];
    $blocktime = $decoded["blocktime"];
    
    
    $sql  = "INSERT INTO `blockchain`.`tx_detail` (`id`, `hex`, `tx`, `version`, `locktime`, `block`, `confirmations`, `time`, `blocktime`) ";
    $sql .= "VALUES (NULL, '$hex', '$txn', '$version', '$locktime', '$block', '$confirmations', '$time', '$blocktime');";
    
    mysql_query($sql);
    echo mysql_error();
    
    // VIN
    
    // coin generation
        
        
    // normal transaction

    // VOUT
    
    foreach($decoded["vout"] as $vout) {
        $value = $vout["value"];
        $n = $vout["n"];
    
        $sql  = "INSERT INTO `blockchain`.`tx_vout` (`id`, `parent_tx`, `value`, `n`) ";
        $sql .= "VALUES (NULL, '$txn', '$value', '$n');";
        
        mysql_query($sql);
        echo mysql_error();
        
        $asm = $vout["scriptPubKey"]["asm"];
        $hex = $vout["scriptPubKey"]["hex"];
        $req_sigs = $vout["scriptPubKey"]["reqSigs"];
        $type = $vout["scriptPubKey"]["type"];
        
        $sql  = "INSERT INTO `blockchain`.`tx_vout_spk` (`id`, `parent_tx`, `asm`, `hex`, `req_sigs`, `type`) ";
        $sql .= "VALUES (NULL, '$txn', '$asm', '$hex', '$req_sigs', '$type');";
        
        mysql_query($sql);
        echo mysql_error();
        
        foreach($vout["scriptPubKey"]["addresses"] as $address) {
            add_transaction_reference($address, $txn);
            
            $sql  = "INSERT INTO `blockchain`.`tx_vout_addr` (`id`, `parent_tx`, `address`) ";
            $sql .= "VALUES (NULL, '$txn', '$address');";
            
            mysql_query($sql);
            echo mysql_error();
        
        }
    }
}

function add_transaction_reference($addr, $transaction) {
    $sql = "INSERT INTO `blockchain`.`addr_tx` (`id`, `address`, `tx_ref`) VALUES (NULL, '$addr', '$transaction');";
    mysql_query($sql);
    echo mysql_error();    
}

// Loop
function main() {
        
        echo "\nblockchain db creator script\n";
        echo "written by Jan Peter Koenig (c) 2013. All rights reserved.\n";
        
        global $start;
        global $tool_name;
        global $destination;
        global $info;
               
	mysql_connect("localhost", "blockchain", "RV9Ls3cy28xXcVhp", "blockchain") or die(mysql_error());
	
	for ($i = $start; $i <= $destination; $i++) {
	        $info = 0;
		$blockhash = shell_exec($tool_name . " getblockhash $i");
		echo "$i (" . trim($blockhash) . ") ";
		
		$json = shell_exec($tool_name . " getblock " . $blockhash);
    
		$decoded = json_decode($json, true);
		process_query($decoded);
		
		echo "($info tx) \n";
	}
}


main();
