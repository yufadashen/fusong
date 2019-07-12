/*
 * 	rent		//��Ⱦ�ؼ�id		
 *  name        //����
 *  data		//����Դ����ʽ["����",����]
 * 	seriesName  //�����ڱ�ͼģ������ʾ���ݵı���
 *  url  		//�����ͼģ����ת��url������hName������������ֵ��hValue����ͼģ���ֵ��
 * 	colName 	//����������ֵ
*/
function highChartPie(rent,name,data,seriesName,url,colName){
	var chartvalue = {
		chart: {
				renderTo: rent, 
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            },
            title: {
                text: name
            },
            tooltip: {
        	    pointFormat: '{series.name}: <b>{point.y}</b>',
            	percentageDecimals: 1
            },
              credits:{
                enabled: false //�Ƿ���ʾ����ˮӡ
        	},
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    size:'75%',
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        color: '#000000',
                        connectorColor: '#000000',
                        formatter: function() {
                            return '<b>'+ this.point.name +'</b>: '+ this.point.y;
                        }
                    }
                }
            },
            series: [{
                type: 'pie',
                name: seriesName,
                data: data,
                cursor: 'pointer', 
	            events: { 
	                click: function(e) { 
	                    parent.$.colorbox({iframe:true,width:"80%", height:"98%",href:url+"?hName="+colName+"&hValue="+e.point.name});
	                } 
	            } 
            }]
	};
	return chartvalue;
};

	