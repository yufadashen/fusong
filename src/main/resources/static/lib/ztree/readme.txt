z_checkBox_tree.js ʹ��˵��
				�˿ؼ�Ϊһ����װ��ztree�����β˵��ؼ�
				֧�ֵ�ѡ�˵��Ͷ�ѡ�˵���
				֧�ֶ�̬�;�̬��ȡ���ݣ�
				֧�ֻص���
				֧���Զ���ͼƬ��
				�����õ�ѡ�˵��Ƿ�ֻ��ѡ��Ҷ�ӽڵ㣻
				�����ö�ѡ�˵����ӽڵ��Ĺ�����ϵ��
				������ѡ��˵���Ŀ�Ⱥ͸߶ȣ�
ʹ�ò���
1��ʹ��ǰ����jquery,ztree���js, css;
		�б����£�zTreeStyle.css  demo.css  jquery-1.4.4.min.js jquery.ztree.core-3.4.js  jquery.ztree.excheck-3.4.js
						
2,����z_checkBox_tree.js

3,��ҳ��js�е��ú��� 
		function showMenu(treeType,isDynamic,url,inputId,hiddenId,resFun,iconInfo,isSelectLeafOnly��psRelation)
						

����showMenu(treeType,isDynamic,url,inputId,imageId,resFun,iconInfo,isSelectLeafOnly,psRelation) ˵�����£�
	treeType ������ ;
					 ��Ϊtrue��Ϊ��ѡ�˵���falseΪ��ѡ�˵�;
					 �Ƿ��Ϊ�գ�����Ϊ��;
	isDynamic 
						�Ƿ�̬��ȡ����; 
						��Ϊtrue����̬��ȡ���ݣ���Ϊfalse�෴��
						�Ƿ��Ϊ�գ�����Ϊ��;
	url			  
					Ϊ��ȡ���ݵ�url����Ϊ��̬���ݡ�
					��isDynamicΪtrue�� urlΪ��ȡ���ݵ�url����isDynamicΪfalse��urlΪ��֯�ľ�̬���ݣ�
					���ݸ�ʽΪjson��ʽ�����飻��ʽ���£�
					var zNodeArray = [{"id":"1","pId":"0","name":"�ճ�����","type":"1"},
								  					{"id":"2","pId":"0","name":"�ֳ����","type":"1"},
								  					{"id":"3","pId":"1","name":"�ϼ�����","type":"2"},
								  					{"id":"4","pId":"1","name":"�ڲ��ļ�","type":"2"},
								  					{"id":"5","pId":"2","name":"��ȾԴ","type":"2"},
								  					{"id":"6","pId":"2","name":"������Ŀ","type":"2"},
								  					{"id":"7","pId":"3","name":"�ϼ�����1","type":"3"},
								  					{"id":"8","pId":"3","name":"�ϼ�����2","type":"3"},
								  					{"id":"9","pId":"4","name":"�ڲ��ļ�1","type":"3"},
								  					{"id":"10","pId":"4","name":"�ڲ��ļ�2","type":"3"}
								  				];
					��ʽ˵����idΪ�ڵ�Ψһ��ʶ��
										pIdΪ�ڵ㸸�ڵ��ʶ��
										nameΪ�ڵ��ڲ˵�����ʾ�����ƣ�
										typeΪ�Զ���ͼ��Ĳ�������typeֵ��iconInfoArray��typeֵ��ͬʱ����ʾiconInfoArray�ж����ͼ�ꣻ			  				
										nocheck Ϊ�ڵ��Ƿ��ѡ��Ϊtrueʱ��ǰ�ڵ㲻��ѡ��
										open ���ýڵ��չ�����۵�״̬��Ϊtrueʱ�ڵ�չ����
										������μ�zTree API��
										����Ҫ��̬��ȡ����,�ɲμ���TaskTypeAction.java��create_tree()����; 
					�Ƿ��Ϊ�գ�����Ϊ��;
	 inputId �����id ;
	 					�Ƿ��Ϊ�գ�����Ϊ��;
	 hiddenId ������id;
	 					�Ƿ��Ϊ�գ�����Ϊ��;
	 resFun 
	 				�ص��������������˻ص������Ĳ���Ϊһ��json��ʽ���飬�����а������е�ǰ��ѡ�еĽڵ���Ϣ��
	 				���û�лص���Ӧ����Ϊnull��
	 				�Ƿ��Ϊ�գ�����Ϊnull;
	 iconInfo 
	 				�Զ���ͼƬ��Ϣ������Ϊjson��ʽ�����顣�����Զ���ͼƬ��Ӧ����Ϊnull;
	 				��ʽ���£�
	 				var iconInfoArray = new Array();
						iconInfoArray[0]={"type":"1","iconClose":"<user:skin value='/scripts/zTree-v3.4/css/zTreeStyle/img/diy/1_open.png'/>","iconOpen":"<user:skin value='/scripts/zTree-v3.4/css/zTreeStyle/img/diy/1_close.png'/>"};
						iconInfoArray[1]={"type":"2","iconClose":"<user:skin value='/scripts/zTree-v3.4/css/zTreeStyle/img/diy/2.png'/>","iconOpen":"<user:skin value='/scripts/zTree-v3.4/css/zTreeStyle/img/diy/3.png'/>"};				
						��ʽ˵����
						type ��Ӧ��ȡ�����е�type
						iconClose �˵��ر�ʱͼ��·��
						iconOpen �˵���ʱͼ��·��	
	 					�Ƿ��Ϊ�գ�����Ϊnull;
		isSelectLeafOnly
					�Ƿ�ֻ��ѡ��Ҷ�ӽڵ㣻ֻ��Ե�ѡ�˵���Ч��
					��Ϊtrueֻ��ѡ��Ҷ�ӽڵ㣬false�෴��
					���Ҫ���ƶ�ѡ�˵��Ľڵ��Ƿ��ѡ��������nocheckΪtrue;
					�Ƿ��Ϊ�գ�����Ϊ��;
		psRelation
					���ӽڵ������ϵ��ֻ�Զ�ѡ�˵���Ч��
					��ʽ���£�
					var psRelation = {"Y":"ps","N":"s"};
					��ʽ˵����
							Y ���ñ���ѡʱ�Ĺ�����ϵ
							N	����ȡ����ѡʱ�Ĺ�����ϵ
								"p" ��ʾ������Ӱ�츸���ڵ㣻
								"s" ��ʾ������Ӱ���Ӽ��ڵ㣻
								"ps"��ʾ������Ӱ�츸�ӽڵ㣻	
						��ע���Сд����Ҫ�ı�	
						�Ƿ��Ϊ�գ�����Ϊnull; ��Ϊnullʱ�����ӽڵ�û�й�����
	 boxSize
	 				ѡ��˵����С����
											�Ƿ��Ϊ�գ�����Ϊnull;��Ϊnull��ʾĬ�ϴ�С��
											��ʽ���£�
											var boxSize = {"width":"300px","height":"450px"};
											��ʽ˵����
											width:�˵����ȣ�����Ϊ�գ�
											height���˵���߶ȣ�����Ϊ�գ�					