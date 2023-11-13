public class CloudsmithsController {
    @AuraEnabled
    public static String   submitCloudsmith(String southAfricaId,String gender,String citizen,String birthDate) {
        System.debug('###birthDate'+birthDate);
        
        Date userBirthDate = Date.newInstance(integer.valueOf(birthDate.split('/')[2]), integer.valueOf(birthDate.split('/')[0]), integer.valueOf(birthDate.split('/')[1]));
         System.debug('###userBirthDate'+userBirthDate);
       // try{
            List<Himanshutakjava__CloudSmiths__c> lstOfClouds=[select id,Himanshutakjava__SA_Citizen__c,Himanshutakjava__south_Africa_Id__c,
                                                               Himanshutakjava__visitor__c,Himanshutakjava__Date_of_Birth__c,
                                                               Himanshutakjava__Gender__c from Himanshutakjava__CloudSmiths__c 
                                                               where south_Africa_Id__c=:southAfricaId];
            if(lstOfClouds.size()==0){
                lstOfClouds.add(new Himanshutakjava__CloudSmiths__c(south_Africa_Id__c=southAfricaId,Himanshutakjava__Gender__c=gender,Himanshutakjava__visitor__c=1,
                                                                    Himanshutakjava__SA_Citizen__c=citizen,Himanshutakjava__Date_of_Birth__c=userBirthDate)); 
            }else{
                lstOfClouds[0].Himanshutakjava__visitor__c=(lstOfClouds[0].Himanshutakjava__visitor__c+1);
            } 
            
            
            
            HttpResponse  response=HttpCalloutCloudsmithsController.getResponse('https://calendarific.com/api/v2/holidays','24c5e86734eb44dc4a962826324a5546e74dc42f','ZA',userBirthDate.Year()+'');
            
        	upsert lstOfClouds;
        	
           if(response.getStatusCode()==200){
                return response.getBody();
            }
        	return '';
            
     //   }catch(Exception ex){
       //     throw new AuraHandledException(ex.getMessage());
        //}
       
    }    
}