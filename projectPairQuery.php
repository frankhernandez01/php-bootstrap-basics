<?PHP
#initialized vars performing ternary operator to grab the values from the post request or set to empty string
$inpdname = isset($_POST['inpdname']) ? $_POST['inpdname'] : '';
$visited = isset($_POST['visited']) ? $_POST['visited'] : '';
$inpdnamemsg = '';
?>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS (adds styling for neat responsive presentation)Using CDN to minimize file dependecies -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
          crossorigin="anonymous">
    <title>Frank ASG-3
    </title>
    <!--in line styles are bad practice making exception to minimize external files-->
    <style>
      .margined {
        margin-top: 2%;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="margined">
        <h2 class="text-center">Project Pairs Query
        </h2>
        <div class="row">
          <div class="col-sm-12 col-lg-8 mx-auto">
            <br>
            <p> 
              <strong>Input:
              </strong> None required
            </p>
            <p> 
              <strong>Desired Output:
              </strong>
              Output the firstname and lastname of each pair of employees who work for 
              the same project. There should not be any duplicate reversed pair 
              and no employee be paired with the same employee.
            </p> 
            <?php
                if (!($inpdname )) {
                    if ($visited) {	  
                    $inpdnamemsg = 'Please enter a dependent name';
                    }
                    require ('./dbConfig.php');
                     $querystring = 
                     "select w1.pno, e1.fname, e1.lname, e2.fname AS First, e2.lname AS Last
                     from works_on AS w1, works_on AS w2,  employee as e1, employee as e2
                     where  w1.pno=w2.pno AND w1.essn < w2.essn AND e1.ssn=w1.essn AND 
                     e2.ssn=w2.essn ORDER by w1.pno";
                    $result = mysqli_query($con, $querystring);
                    if (!$result) {
                      print ( "Could not successfully run query ($querystring) from DB: " . mysqli_error($con) . "<br>");
                      exit;
                    }
                  
                    if (mysqli_num_rows($result) == 0) {
                      print ("No rows found, nothing to print so am exiting<br>");
                      exit;
                    }
                  
                        // Print the column names as the headers of a table
                        echo '<table border="1|0"><tr>';
                        for($i = 0; $i < mysqli_num_fields($result); $i++) {
                            $field_info = mysqli_fetch_field($result);
                            echo "<th>{$field_info->name}</th>";
                        }
    
                        // Print the data
                        while($row = mysqli_fetch_row($result)) {
                            echo "<tr>";
                            foreach($row as $_column) {
                                echo "<td>  {$_column}  </td>";
                            }
                            echo "</tr>";
                        }
    
                        echo "</table>";
                    mysqli_close($con);
                }
            ?>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
