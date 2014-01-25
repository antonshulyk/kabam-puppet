var config = require ('conf.js').config;
var HOST = config.baseURL;
var username = 'user1';
var password = 'user1';

describe('In agularjs page', function(){
    
    var ptor = protractor.getInstance();
    var pro = protractor.By;
    var driver = ptor.driver;

    driver.get(HOST);

    // click button login
    driver.findElement(protractor.By.css('.fa-arrow-circle-o-right')).click();
    
    // Enter login info
    driver.findElement(protractor.By.name('username')).sendKeys(username);
    driver.findElement(protractor.By.name('password')).sendKeys(password);

    //click login button
    driver.findElement(protractor.By.id('edit-submit')).click();

    it('Should edit profile', function(){

	ptor.sleep(2000);
	// navigate to #/profile
	ptor.findElement(pro.className('fa-cog')).click();
	
	var li = ptor.findElement(pro.css('.user-settings'));
	li.findElements(pro.tagName('li')).then(function(e){
	e[0].findElement(pro.tagName('a')).click();
        });

	// edit profile name
        var profile = ptor.findElement(pro.className('profile-name'));
        profile.findElements(pro.tagName('span')).then(function(sp){
    	    sp[sp.length - 1].findElement(pro.tagName('a')).click();
        });

        profile.findElements(pro.model('$data')).then(function(md){
	// replace text if exit
	    md[0].sendKeys(protractor.Key.chord(protractor.Key.CONTROL, "a"));
	    md[0].sendKeys('First');
	// replace text if exit
	    md[1].sendKeys(protractor.Key.chord(protractor.Key.CONTROL, "a"));
	    md[1].sendKeys('Last', protractor.Key.ENTER);
	});

        profile.findElements(pro.tagName('span')).then(function(sp){
	    expect(sp[0].getText()).toEqual('First');
	    expect(sp[1].getText()).toEqual('Last');
        });
    });
});
