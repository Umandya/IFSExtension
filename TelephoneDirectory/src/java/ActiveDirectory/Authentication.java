/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ActiveDirectory;


import DbConnect.dbConnection;
import Model.User;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;
import javax.naming.Context;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attributes;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.naming.ldap.InitialLdapContext;
import javax.naming.ldap.LdapContext;

/**
 *
 * @author namalk
 */
public class Authentication {

    private ArrayList<User> teamMembers;
    private  ArrayList<User> directors = new ArrayList<>();
    private DbConnect.dbConnection  connection ;
    InitialLdapContext ctx;
    
    
    public String authenticate(String user) throws IOException {
        String status = null;//director,manager,member
        try {
            NamingEnumeration answer;
            
            // Set up the environment for creating the initial context
              Hashtable<String, String> env = new Hashtable<String, String>();
            env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
            env.put(Context.PROVIDER_URL, "LDAP://CMBCNDC2.corpnet.ifsworld.com/");

            env.put(Context.SECURITY_AUTHENTICATION, "simple");
            env.put(Context.SECURITY_PRINCIPAL, "corpnet\\umchlk");
            env.put(Context.SECURITY_CREDENTIALS, "Uma1Ndya123");
            
            status = "member";
            //part 2
            SearchControls searchControls = new SearchControls();                           
            searchControls.setSearchScope(SearchControls.SUBTREE_SCOPE);
            ctx = new InitialLdapContext(env, null); 
            
            //check whether the user is a manager
//           answer = ctx.search("CN=All Software Dev & IS Managers.LK,OU=Mail,OU=IFSGroups,DC=corpnet,DC=ifsworld,DC=com", "sAMAccountName=" + user, searchControls);
//            
//            while (answer != null && answer.hasMore()) {
//                status = "manager";
//               
//            }            
//            
//            //check whether the user is a director
//             answer = ctx.search("CN=Directors.LK,OU=Mail,OU=IFSGroups,DC=corpnet,DC=ifsworld,DC=com", "sAMAccountName=" + user, searchControls);
//            
//            while (answer != null && answer.hasMore()) {
//                status = "director";
//                
//            }
            
            status = identifyAdmin(user);
            System.out.println("Admin:"+status);
            
            System.out.println("OK, successfully authenticating user");
            
            
                  
          //end part 2           
            
             

        } catch (NamingException ne) {
            System.out.println("Error authenticating user:");
            System.out.println(ne.getMessage());           
        }

        //if no exception, the user is already authenticated.
       //status = "manager"; //for testing 
       return status;
       

    }
    
    public String identifyAdmin(String user) throws NamingException{
        String status ="member";
        NamingEnumeration answer;
        NamingEnumeration memberAnswer;
        
        Hashtable<String, String> env = new Hashtable<String, String>();
        env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        env.put(Context.PROVIDER_URL, "LDAP://CMBCNDC2.corpnet.ifsworld.com/");

        env.put(Context.SECURITY_AUTHENTICATION, "simple");
        env.put(Context.SECURITY_PRINCIPAL, "corpnet\\umchlk" );
        env.put(Context.SECURITY_CREDENTIALS, "Uma1Ndya123" );  
        
        SearchControls searchControls = new SearchControls();
        searchControls.setSearchScope(SearchControls.SUBTREE_SCOPE);
        
        SearchControls membersearchControls = new SearchControls();
        membersearchControls.setSearchScope(SearchControls.SUBTREE_SCOPE);
        
        ctx = new InitialLdapContext(env, null);
        
        System.out.println("identify admin");
        
            ArrayList<String> urlList = new ArrayList<>();
        
        String url = "CN=All Software Dev & IS Managers.CMB,OU=Mail,OU=IFSGroups,DC=corpnet,DC=ifsworld,DC=com";
        
        answer = ctx.search(url, "cn=All Software Dev & IS Managers.CMB", searchControls);
        System.out.println((answer!=null)+" "+ answer.hasMore());
        while (answer != null && answer.hasMore()) {            
            SearchResult entry = (SearchResult)answer.next();
            Attributes attributes = entry.getAttributes ();
            String name = attributes.get("member").toString().replace("member:", "");
            String nameArray[] = name.split(",\\s");
            
            for(int i=0; i<nameArray.length;i++){
                nameArray[i] = nameArray[i].trim();
                urlList.add(nameArray[i]);
            //    System.out.println("step 1: "+nameArray[i]);
            }
        }
        
        url = "CN=Directors.CMB,OU=Mail,OU=IFSGroups,DC=corpnet,DC=ifsworld,DC=com";
        answer = ctx.search(url, "CN=Directors.CMB", searchControls);
        System.out.println((answer!=null)+" "+ answer.hasMore());
        while(answer !=null && answer.hasMore()){
            SearchResult entry = (SearchResult)answer.next();
            Attributes attributes = entry.getAttributes ();
            String name = attributes.get("member").toString().replace("member:", "");
            String nameArray[] = name.split(",\\s");
            
            for(int i=0; i<nameArray.length;i++){
                nameArray[i] = nameArray[i].trim();
                urlList.add(nameArray[i]);
            //    System.out.println("step 2:"+nameArray[i]);
            }
        }
        
        answer = ctx.search("OU=Employees,OU=IFSUsers,DC=corpnet,DC=ifsworld,DC=com ", "sAMAccountName=" + user,searchControls);
        if(answer.hasMore()){
            SearchResult entry = (SearchResult)answer.next();
            Attributes attributes = entry.getAttributes ();
            String name = attributes.get("memberOf").toString().replace("memberOf:", "");
            String nameArray[] = name.split(",\\s");
            for(int i=0; i< nameArray.length;i++){
            //    System.out.println("step 3: "+nameArray[i]);
                nameArray[i] = nameArray[i].trim();
                for(String u: urlList){
                   //System.out.println("STEP 4 :"+u + " CHECK "+ nameArray[i]);
                   // System.out.println("admin checking "+u.matches(nameArray[i]));
//                   
                   if(u.matches(nameArray[i])){
                       // System.out.println("step 5: Admin");
                        status = "admin";
                        return status;
                   }else if(user.matches("umchlk") ||user.matches("narblk")) {
                       //System.out.println("step 5: Admin");
                        status = "admin";
                    }
                }
                
                if(status == "admin"){
                    break;
                }
            }
            
        }
        
        
        
        
        
        
        System.out.println(status + " " + user);
        return status;
    }
    
    //Get the url of the diect reports
    public ArrayList<User> memberNames(String supervisorName,String user) throws NamingException, SQLException{
       
        ArrayList<User> directReports = new ArrayList<>();
        NamingEnumeration answer;
        NamingEnumeration memberAnswer;
        String managerURL = null;
        
        Hashtable<String, String> env = new Hashtable<String, String>();
        env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        env.put(Context.PROVIDER_URL, "LDAP://CMBCNDC2.corpnet.ifsworld.com/");

        env.put(Context.SECURITY_AUTHENTICATION, "simple");
        env.put(Context.SECURITY_PRINCIPAL, "corpnet\\umchlk" );
        env.put(Context.SECURITY_CREDENTIALS, "Uma1Ndya123" );  
        
        SearchControls searchControls = new SearchControls();
        searchControls.setSearchScope(SearchControls.SUBTREE_SCOPE);
        
        SearchControls membersearchControls = new SearchControls();
        membersearchControls.setSearchScope(SearchControls.SUBTREE_SCOPE);
                           
        System.out.println("authenticate");    
        InitialLdapContext ctx = new InitialLdapContext(env, null);
       
            
        return directReports;
    }
    
        public String authenticate2(String user) {
        try {
            // Set up the environment for creating the initial context
            Hashtable<String, String> env = new Hashtable<String, String>();
            env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
            env.put(Context.PROVIDER_URL, "LDAP://CMBCNDC2.corpnet.ifsworld.com/");

            env.put(Context.SECURITY_AUTHENTICATION, "simple");
            env.put(Context.SECURITY_PRINCIPAL, "corpnet\\umchlk");
            env.put(Context.SECURITY_CREDENTIALS, "Uma1Ndya123");

            ctx = new InitialLdapContext(env, null);
            //   String work="corpnet\\" + "namalk";
            System.out.println("OK, successfully authenticating user");
            System.out.println(user);
            String user2;
            user2 = getUserName(user, ctx);
            System.out.println("OK, successfully authenticating user "+user2);
            return user2;


        } catch (NamingException ne) {
            System.out.println("Error authenticating user:");
            System.out.println(ne.getMessage());
            return null;

        }

        //if no exception, the user is already authenticated.
    }

    public  String getUserName(String username, LdapContext ctx) {
        try {
            SearchControls constraints = new SearchControls();
            constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);

            String[] attrIDs = {"cn"};
            constraints.setReturningAttributes(attrIDs);

           NamingEnumeration answer = ctx.search("OU=Employees,OU=IFSUsers,DC=corpnet,DC=ifsworld,DC=com ", "sAMAccountName=" + username, constraints);
           
              if (answer.hasMore()) {
                System.out.println("yess");
                Attributes attrs = ((SearchResult) answer.next()).getAttributes();
                return attrs.get("cn").toString().replace("cn:", "");
            } else {
                return null;
            }

        } catch (Exception ex) {
        }
        return null;
    }
    
    
    public String checkNewEmployee(String username) throws ClassNotFoundException, SQLException{
        String status = "new";
        connection = new dbConnection();
        boolean tmp = connection.getEmployee(username);
        
        if(tmp){
            status = "old";
        }else{
            status=authenticate2(username);
            try{
                SearchControls constraints = new SearchControls();
            constraints.setSearchScope(SearchControls.SUBTREE_SCOPE);
                NamingEnumeration answer = ctx.search("OU=Employees,OU=IFSUsers,DC=corpnet,DC=ifsworld,DC=com ", "sAMAccountName=" + username, constraints);
                if(answer.hasMore()){
                    Attributes attrs = ((SearchResult) answer.next()).getAttributes();
                    status = attrs.get("cn").toString().replace("cn:", ""); 
                   
                }
            }catch(NamingException e){
                status = "no";
            }
            
            
        }
        return status; 
   }
    
}