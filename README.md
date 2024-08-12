# utl-python-send-a-list-of-zipcodes-to-a-website-and-get-associated--latititude-and-longitudes
Python send a list of zipcodes to a website and get associated  latititude and longitudes
    %let pgm=utl-python-send-a-list-of-zipcodes-to-a-website-and-get-associated--latititude-and-longitudes;

    Python send a list of zipcodes to a website and get associated  latititude and longitudes

        Sections

          1 stackoverflow python
             https://stackoverflow.com/users/10035985/andrej-kesely
          2 updated frop down to python
             added resolve option so macro objects can be resolved
          3 related repos


    github
    https://tinyurl.com/mr6h3f3c
    https://github.com/rogerjdeangelis/utl-python-send-a-list-of-zipcodes-to-a-website-and-get-associated--latititude-and-longitudes

    stackoverflow
    https://tinyurl.com/2fxeccbh
    https://stackoverflow.com/questions/78861446/scrape-the-latitude-and-longitude-from-the-website

    No need for a local file of zips and lat long

    Good Site
    https://www.freemaptools.com

    For info on zip to lat long
    https://www.freemaptools.com/map-tools.htm#google_vignette

    Tools that are specific to the USA and concern ZIP codes
      Convert USA ZIP Code to Latitude / Longitude

    For Batch access
    https://www.freemaptools.com/contact.htm
    https://www.perplexity.ai/search/how-do-i-get-an-api-key-from-f-V50hupRxR9.KZvXQ_D.Ruw

    /*
     _      _             _                        __ _                             _   _
    / | ___| |_ __ _  ___| | _______   _____ _ __ / _| | _____      __  _ __  _   _| |_| |__   ___  _ __
    | |/ __| __/ _` |/ __| |/ / _ \ \ / / _ \ `__| |_| |/ _ \ \ /\ / / | `_ \| | | | __| `_ \ / _ \| `_ \
    | |\__ \ || (_| | (__|   < (_) \ V /  __/ |  |  _| | (_) \ V  V /  | |_) | |_| | |_| | | | (_) | | | |
    |_||___/\__\__,_|\___|_|\_\___/ \_/ \___|_|  |_| |_|\___/ \_/\_/   | .__/ \__, |\__|_| |_|\___/|_| |_|
     _                   _                                             |_|    |___/
    (_)_ __  _ __  _   _| |_
    | | `_ \| `_ \| | | | __|
    | | | | | |_) | |_| | |_
    |_|_| |_| .__/ \__,_|\__|
            |_|
    */

    %symdel key zips / nowarn;

    %let zips="97048", "63640", "63628";

    %put &=zips;

    /**************************************************************************************************************************/
    /*                                                                                                                        */
    /* %put &=zips;                                                                                                           */
    /*                                                                                                                        */
    /* Macro variable ZIPS resolves to "97048", "63640", "63628"                                                              */
    /*                                                                                                                        */
    /* ZIPS="97048", "63640", "63628"                                                                                         */
    /*                                                                                                                        */
    /**************************************************************************************************************************/

    /*
     _ __  _ __ ___   ___ ___  ___ ___
    | `_ \| `__/ _ \ / __/ _ \/ __/ __|
    | |_) | | | (_) | (_|  __/\__ \__ \
    | .__/|_|  \___/ \___\___||___/___/
    |_|
    */

    %utl_pybeginx;
    parmcards4;
    import requests

    api_url = (
        "https://api.promaptools.com/service/us/zip-lat-lng/get/?zip={}&key=17o8dysaCDrgvlc"
    )

    zips = [&zips]

    headers = {
        "Origin": "https://www.freemaptools.com",
    }

    for z in zips:
        url = api_url.format(z)
        data = requests.get(url, headers=headers).json()
        print(z, data)
    ;;;;
    %utl_pyendx(resolve=Y);

    /**************************************************************************************************************************/
    /*                                                                                                                        */
    /* 97048 {'status': 1, 'output': [{'zip': '97048', 'latitude': '46.053228', 'longitude': '-122.971330'}]}                 */
    /* 63640 {'status': 1, 'output': [{'zip': '63640', 'latitude': '37.747435', 'longitude': '-90.363484'}]}                  */
    /* 63628 {'status': 1, 'output': [{'zip': '63628', 'latitude': '37.942778', 'longitude': '-90.484430'}]}                  */
    /*                                                                                                                        */
    /**************************************************************************************************************************/
    /*___                    _       _           _               _   _                      _                     _
    |___ \   _   _ _ __   __| | __ _| |_ ___  __| |  _ __  _   _| |_| |__   ___  _ __    __| |_ __ ___  _ __   __| | _____      ___ __
      __) | | | | | `_ \ / _` |/ _` | __/ _ \/ _` | | `_ \| | | | __| `_ \ / _ \| `_ \  / _` | `__/ _ \| `_ \ / _` |/ _ \ \ /\ / / `_ \
     / __/  | |_| | |_) | (_| | (_| | ||  __/ (_| | | |_) | |_| | |_| | | | (_) | | | || (_| | | | (_) | |_) | (_| | (_) \ V  V /| | | |
    |_____|  \__,_| .__/ \__,_|\__,_|\__\___|\__,_| | .__/ \__, |\__|_| |_|\___/|_| |_| \__,_|_|  \___/| .__/ \__,_|\___/ \_/\_/ |_| |_|
                  |_|                               |_|    |___/                                       |_|

    */
    %macro utl_pyendx(return=,resolve=N);
    run;quit;
    data _null_;
      infile "c:/temp/py_pgm.pyx";
      input;
      file "c:/temp/py_pgm.py";
      if upcase(substr("&resolve",1,1))="Y" then
         _infile_=resolve(_infile_);
      put _infile_;
      putlog _infile_;
    run;quit;
    * EXECUTE THE PYTHON PROGRAM;
    options noxwait noxsync;
    filename rut pipe  "d:\Python310\python.exe c:/temp/py_pgm.py 2> c:/temp/py_pgm.log";
    run;quit;
    data _null_;
      file print;
      infile rut;
      input;
      put _infile_;
      putlog _infile_;
    run;quit;
    data _null_;
      infile "c:/temp/py_pgm.log";
      input;
      putlog _infile_;
    run;quit;
    %if "&return" ne ""  %then %do;
      filename clp clipbrd ;
      data _null_;
       infile clp;
       input;
       putlog "xxxxxx  " _infile_;
       call symputx("&return.",_infile_,"G");
      run;quit;
      %end;
      filename ft15f001 clear;
    %mend utl_pyendx;


    Related repos

    /*        _       _           _
     _ __ ___| | __ _| |_ ___  __| |  _ __ ___ _ __   ___  ___
    | `__/ _ \ |/ _` | __/ _ \/ _` | | `__/ _ \ `_ \ / _ \/ __|
    | | |  __/ | (_| | ||  __/ (_| | | | |  __/ |_) | (_) \__ \
    |_|  \___|_|\__,_|\__\___|\__,_| |_|  \___| .__/ \___/|___/
                                              |_|
    */
    https//github.com/rogerjdeangelis/utl-identifying-html-nodes-and-extracting-specific-information-scraping-html
    https//github.com/rogerjdeangelis/utl-identifying-the-html-table-and-exporting-to-spss-then-sas-scraping
    https//github.com/rogerjdeangelis/utl-locating-the-html-node-and-web-scrape-the-html-table
    https//github.com/rogerjdeangelis/utl-python-scrape-web-page-source-and-save-to-local-file-like-view-source-but-programatically
    https//github.com/rogerjdeangelis/utl-sas-scraping-connections-on-linkedIn-and-output-in-sas-dataset
    https//github.com/rogerjdeangelis/utl-scrape-weather-conditions-for-a-past-march-red-sox-vs-orioles-game-
    https//github.com/rogerjdeangelis/utl-scraping-a-single-indirect-html-reference-using-python-beautiful-soup-and-request-packages
    https//github.com/rogerjdeangelis/utl-scraping-a-web-page-with-three-by-three-set-of-finacial-tables
    https//github.com/rogerjdeangelis/utl-scraping-AI-results-without-restriction-or-API-with-powershell-and-perplexity
    https//github.com/rogerjdeangelis/utl-scraping-pdf-output-for-pdf-tables-and-lists
    https//github.com/rogerjdeangelis/utl-scraping-san-francisco-hourly-weather-forecast-reading-xml-on-the-web
    https//github.com/rogerjdeangelis/utl-scraping-server-screens-when-Copy-Print-PageSource-are-disabled-python-tesseract
    https//github.com/rogerjdeangelis/utl-using-r-rvest-to-scrape-the-web-for-brazil-world-cup-performance
    https//github.com/rogerjdeangelis/utl-web-scaping-Loop-over-many-URLs-scrape-parse-extract-nodes-and-put-into-a-sas-table
    https//github.com/rogerjdeangelis/utl-web-scraping-a-large-wikipedia-html-table-user-R-rvest
    https//github.com/rogerjdeangelis/utl-Web-Scraping-data-from-Australian-Open-stats
    https//github.com/rogerjdeangelis/utl-web-scraping-spains-grananda-soccer-team-players
    https//github.com/rogerjdeangelis/utl-web-scraping-USDOT-vehicle-inspections-and-fatalities
    https//github.com/rogerjdeangelis/utl_scrape_javascript_converting_table_to_sas_dataset_no_browser
    https//github.com/rogerjdeangelis/utl_scraping_javascript_generated_html_web_pages
    https//github.com/rogerjdeangelis/utl_scraping_mutiple_web_tables_and_creating_seven_database_tables
    https//github.com/rogerjdeangelis/utl_webscraping_www.treasury.gov__xml_page_of_interest_rates
    https//github.com/rogerjdeangelis/utl_web_scrape_23_separate_pages_one_per_state_for_all_whole_food_store_addresses
    https//github.com/rogerjdeangelis/utl_web_scraping_programatically_using_a_web_search_box_and_retrieve_information
    https//github.com/rogerjdeangelis/utl_web_scraping_top_cnn_stories
    https//github.com/rogerjdeangelis/utl_web_scraping_web_pages_for_the_latest_news_on_the_food_shortage_in_yemen

    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */
