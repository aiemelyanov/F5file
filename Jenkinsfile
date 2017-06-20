node {
   stage('Preparation') {
      // Get some code from a GitHub repository
      git 'https://github.com/jmcalalang/F5file.git'
   }
   stage('Testing') {
      //Run the tests
      sh "/usr/local/bin/ansible-lint F5file_build.yml"
      sh "/usr/local/bin/ansible-review F5file_build.yml"
   }
   stage('Build') {
       //Ansible Playbook
       ansiblePlaybook(
         colorized: true,
         inventory: 'hosts.ini',
         playbook: 'F5file_build.yml',
         sudoUser: null,
         extraVars: [
            username: 'azureuser',
            password: [value: 'Harrison123!', hidden: true],
            hosts: 'bigip_hosts'
         ])
      //chatops slack message that ansible run has completed
      slackSend(
         channel: '#jenkins-builds',
         color: 'good',
         message: 'jc-demo-f5 Build ran successfully, make sure site is in maintenance mode http://jc-demof5-wp01-pip.westus2.cloudapp.azure.com, begin server builds then someone approve this Continuous Delivery!',
         teamDomain: 'uniopsteam',
         token: 'zkMRYtEXCEG3Q2FlUsS2Hjjv'
         )
   }
   stage('Approval') {
      //Gate the process and require approval
      input 'Proceed?'
   }
   stage('Re-Enable') {
       //Ansible Playbook
       ansiblePlaybook(
         colorized: true,
         inventory: 'hosts.ini',
         playbook: 'F5file_enable.yml',
         sudoUser: null,
         extraVars: [
            username: 'azureuser',
            password: [value: 'Harrison123!', hidden: true],
            hosts: 'bigip_hosts'
         ])
      //chatops slack message that ansible run has completed
      slackSend(
         channel: '#jenkins-builds',
         color: 'good',
         message: 'jc-demo-f5 Node 192.168.3.5 was re-enabled, production is online',
         teamDomain: 'uniopsteam',
         token: 'zkMRYtEXCEG3Q2FlUsS2Hjjv'
         )
   }
}
