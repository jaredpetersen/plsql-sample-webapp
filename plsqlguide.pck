create or replace package plsqlguide is

-- Author  : Jared Petersen
-- Created : 9/22/2015 12:26:22 AM
-- Purpose : Basic PLSQL template/guide
 
/* Procedures */
procedure p_main;

procedure p_new_item;

procedure insert_item(p_name varchar2, p_quant number, p_price number);

end plsqlguide;
/
create or replace package body plsqlguide is

/* Header Navbar, used on all of the pages */
procedure navbar
	is
begin
	
htp.prn('
	<nav class="navbar navbar-default navbar-static-top">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="jpetersen11.plsqlguide.p_main">PL/SQL Sample Application</a>
			</div>
		</div>
	</nav>
');
	
end navbar;

/* Main entry point (homepage) */
procedure p_main
	is
begin

htp.prn('
	<!DOCTYPE html>
		<html lang="en">
		<head>
			<meta charset="utf-8">
			<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
			<title>PL/SQL Sample Application</title>

			<!-- Bootstrap -->
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

			<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
			<!--[if lt IE 9]>
				<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
				<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
			<![endif]-->
		</head>
		<body>
			<!-- Static navbar -->
');

-- Header Navbar
navbar;

htp.prn('
			<div class="container">
				<p>
					<a href="jpetersen11.plsqlguide.p_new_item">
						<span class="glyphicon glyphicon-plus" aria-hidden="true"></span> <strong>New Item</strong>
					</a>
				</p>
				<table class="table table-bordered">
					<tr>
						<th>#</th>
						<th>Name</th>
						<th>Quantity</th>
						<th>Price</th>
					</tr>
');

-- Fill out the parts table
for row in (select * from parts) loop
	htp.prn('
						<tr>
							<td>'||row.pid||'</td>
							<td>'||row.name||'</td>
							<td>'||row.quantity||'</td>
							<td>'||row.price||'</td>
						</tr>
	');
end loop;
				
htp.prn('
    		</table>
			</div> <!-- /container -->

			<!-- jQuery (necessary for Bootstrap''s JavaScript plugins) -->
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
			<!-- Include all compiled plugins (below), or include individual files as needed -->
			<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
		</body>
	</html>
');
	
end p_main;

/* New Item Page */
procedure p_new_item
	is
begin
	
htp.prn('
	<!DOCTYPE html>
		<html lang="en">
		<head>
			<meta charset="utf-8">
			<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
			<title>PL/SQL Sample Application</title>

			<!-- Bootstrap -->
			<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

			<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
			<!--[if lt IE 9]>
				<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
				<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
			<![endif]-->
		</head>
		<body>
		
			<!-- Static navbar -->
');

-- Header Navbar
navbar;

htp.prn('
			<div class="container">
				<h4><strong>New Item</strong></h4>
				<form action="jpetersen11.plsqlguide.insert_item" method="post">
					<input name="p_name" type="text" class="form-control" placeholder="Name"><br />
					<input name="p_quant" type="text" class="form-control" placeholder="Quantity"><br />
					<div class="input-group">
						<span class="input-group-addon">$</span>
						<input name="p_price" type="text" class="form-control" placeholder="Price">
					</div><br />
					<button type="submit" class="btn btn-default">Submit</button>
				</form>
			</div>
		
		</body>
	</html>
');
	
end p_new_item;

/* Insert Item Logic */
procedure insert_item(p_name varchar2, p_quant number, p_price number)
	is
		v_item_no number;
begin

-- Grab the new item ID
SELECT SEQ_PARTS.NEXTVAL INTO v_item_no FROM DUAL;

-- Insert the item into the table
INSERT INTO PARTS (PID, NAME, QUANTITY, PRICE)
VALUES (v_item_no, UPPER(p_name), p_quant, p_price);

-- Redirect the user back to the home page
htp.prn('<script> window.location = "jpetersen11.plsqlguide.p_main"; </script>');

end insert_item;

begin
  -- Initialization
  null;
end plsqlguide;
/
