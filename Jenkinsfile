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
         message: 'Jon jc-demo-f5 Build Ran Successfully',
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
         message: 'Jon jc-demo-f5 Node Re-enabled',
         teamDomain: 'uniopsteam',
         token: 'zkMRYtEXCEG3Q2FlUsS2Hjjv'
         )
   }
}
