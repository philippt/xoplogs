	var options = {
	    series: {
			stack: true,
	        lines: { show: true },
	        points: { show: true }
	    },
	    xaxis: { mode: "time" },
	    yaxis: {  },
	    selection: { mode: "x" },
	    grid: { hoverable: false, clickable: false }
	};
	
	// div_name => { url => data }
	//var allData = new Hash();
	var allData = {};
	
	// adds a new data line to the graph
	// @param graphDiv is the 'id' of the div element holding the graph
	// @param identifier can be used to remove or modify the data line later on
	// @param dataUrl gets called to fetch the data itself
	// @param callback if != nil, this method gets called after the data is fetched. might
	// be useful e.g. for specifying graph options
	function addLine(graphDiv, identifier, dataUrl, callback) {
	
	  function onDataReceived(series) {
	    graphData = allData[graphDiv];
	    if (! graphData) {
	      graphData = {};
	    }
	    if (callback) {
	      callback(series);
	    }
	    
	    graphData[identifier] = series;
	    allData[graphDiv] = graphData;
	    
	    replot(graphDiv);
	  }
	
	  jQuery.ajax({
	      url: dataUrl,
	      method: 'GET',
	      dataType: 'json',
	      success: onDataReceived
	  });
	
	}
	
	function removeLine(graphDiv, identifier) {
	    allLines = allData.get(graphDiv);
	    allLines.unset(identifier);
	    allData.set(graphDiv, allLines);
	    replot(graphDiv);
	}
	
	
	function replot(divName) {
	  //alert("replotting " + allData.get(divName).size() + " series : " + dump(allData));
	  //alert("keys : " + allData.get(divName).keys().join("\n"));
	  data = [];
	
	  var lines = allData[divName];
	  for (var key in lines) {
	  	data.push(lines[key])
	  }
	
	  jQuery.plot(jQuery('#' + divName), data, options);
	}
