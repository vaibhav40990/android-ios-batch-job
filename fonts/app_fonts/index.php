<?php 
// if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
// 	// return only the headers and not the content
// 	// only allow CORS if we're doing a GET - i.e. no saving for now.
// 	if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD'])) {
// 		header("Access-Control-Allow-Origin: *");
//  		header('Access-Control-Allow-Headers: *');//10-11-15 :: vj : Cversion changed to Code-Version
// 	}
// 	exit;
// }
	$uri = explode("/", $_SERVER['REQUEST_URI']);
	$uri = end($uri);
	$uri = explode("?", $uri);
	$uri = $uri[0];
	if(file_exists($uri)){
		header("Access-Control-Allow-Origin: *");
		header('Access-Control-Allow-Headers: *');
		header('Content-Description: File Transfer');
		header('Content-Type: text/css');
	    header('Content-Disposition: attachment; filename="'.basename($uri).'"');
	    header('Expires: 0');
	    header('Cache-Control: must-revalidate');
	    header('Pragma: public');
	    header('Content-Length: ' . filesize($uri));
	    readfile($uri);
	    exit;
	}
?>