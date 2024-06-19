const express = require('express');
var bodyParser = require('body-parser')
const app = express();
const oracledb = require('oracledb');
const config = require('./dbConfig.js');
console.log('starting serverjs'); 
async function runTest(pname) {
  let conn;
	   
  try {
    conn = await oracledb.getConnection(config);
			 
    const result = await conn.execute(
      "insert into pacmanscores values (\'"+pname+"\',30)"
    );
			     
    console.log(result);
  } catch (err) {
    console.error(err);
  } finally {
    if (conn) {
      try {
	promise = conn.commit();      
        await conn.close();
      } catch (err) {
        console.error(err);
      }
    }
  }
}
 
 
var urlencodedParser = bodyParser.urlencoded({ extended: false })
    
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/index.html');
});
console.log('opening index.html');    
app.post('/', urlencodedParser, (req, res) => {
    console.log('Got body:', req.body);
    console.log('pname:', req.body.pname);
    runTest(req.body.pname);
    res.sendStatus(200);
});
    
app.listen(8080);
