if polyglot#init#is_disabled(expand('<sfile>:p'), 'jenkins', 'syntax/Jenkinsfile.vim')
  finish
endif

runtime syntax/groovy.vim
syn keyword jenkinsfileBuiltInVariable currentBuild

syn keyword jenkinsfileSection pipeline agent stages steps post

syn keyword jenkinsfileDirective environment options parameters triggers stage tools input when libraries

syn keyword jenkinsfileOption contained buildDiscarder disableConcurrentBuilds overrideIndexTriggers skipDefaultCheckout nextgroup=jenkinsfileOptionParams
syn keyword jenkinsfileOption contained skipStagesAfterUnstable checkoutToSubdirectory timeout retry timestamps nextgroup=jenkinsfileOptionParams
syn keyword jenkinsfileOption contained disableResume newContainerPerStage preserveStashes quietPeriod parallelsAlwaysFailFast nextgroup=jenkinsfileOptionParams
syn region  jenkinsfileOptionParams contained start='(' end=')' transparent contains=@groovyTop
syn match   jenkinsfileOptionO /[a-zA-Z]\+([^)]*)/ contains=jenkinsfileOption,jenkinsfileOptionParams transparent containedin=groovyParenT1

syn keyword jenkinsfileCoreStep checkout
syn keyword jenkinsfileCoreStep docker dockerfile skipwhite nextgroup=jenkinsFileDockerConfigBlock
syn keyword jenkinsfileCoreStep node
syn keyword jenkinsfileCoreStep scm
syn keyword jenkinsfileCoreStep sh
syn keyword jenkinsfileCoreStep stage
syn keyword jenkinsfileCoreStep parallel
syn keyword jenkinsfileCoreStep steps
syn keyword jenkinsfileCoreStep step
syn keyword jenkinsfileCoreStep tool

" TODO: These should probably be broken out.
syn keyword jenkinsfileCoreStep always changed failure success unstable aborted unsuccessful regression fixed cleanup

syn region  jenkinsFileDockerConfigBlock contained start='{' end='}' contains=groovyString,jenkinsfileDockerKeyword transparent
syn keyword jenkinsFileDockerKeyword contained image args additionalBuildArgs label registryUrl registryCredentialsId alwaysPull filename dir

syn keyword jenkinsfilePipelineStep Applitools ArtifactoryGradleBuild Consul MavenDescriptorStep OneSky VersionNumber
syn keyword jenkinsfilePipelineStep ViolationsToBitbucketServer ViolationsToGitHub ViolationsToGitLab _OcAction _OcContextInit
syn keyword jenkinsfilePipelineStep _OcWatch acceptGitLabMR acsDeploy activateDTConfiguration addBadge addErrorBadge
syn keyword jenkinsfilePipelineStep addGitLabMRComment addInfoBadge addInteractivePromotion addShortText addWarningBadge
syn keyword jenkinsfilePipelineStep allure anchore androidApkMove androidApkUpload androidLint ansiColor ansiblePlaybook
syn keyword jenkinsfilePipelineStep ansibleTower ansibleVault appMonBuildEnvironment appMonPublishTestResults appMonRegisterTestRun
syn keyword jenkinsfilePipelineStep applatix approveReceivedEvent approveRequestedEvent aqua archive archiveArtifacts
syn keyword jenkinsfilePipelineStep arestocats artifactResolver artifactoryDistributeBuild artifactoryDownload artifactoryMavenBuild
syn keyword jenkinsfilePipelineStep artifactoryPromoteBuild artifactoryUpload awaitDeployment awaitDeploymentCompletion
syn keyword jenkinsfilePipelineStep awsCodeBuild awsIdentity azureCLI azureDownload azureFunctionAppPublish azureUpload
syn keyword jenkinsfilePipelineStep azureVMSSUpdate azureVMSSUpdateInstances azureWebAppPublish backlogPullRequest bat
syn keyword jenkinsfilePipelineStep bearychatSend benchmark bitbucketStatusNotify blazeMeterTest build buildBamboo buildImage
syn keyword jenkinsfilePipelineStep bzt cache catchError cbt cbtScreenshotsTest cbtSeleniumTest cfInvalidate cfnCreateChangeSet
syn keyword jenkinsfilePipelineStep cfnDelete cfnDeleteStackSet cfnDescribe cfnExecuteChangeSet cfnExports cfnUpdate
syn keyword jenkinsfilePipelineStep cfnUpdateStackSet cfnValidate changeAsmVer checkstyle chefSinatraStep cifsPublisher
syn keyword jenkinsfilePipelineStep cleanWs cleanup cloudshareDockerMachine cm cmake cmakeBuild cobertura codefreshLaunch
syn keyword jenkinsfilePipelineStep codefreshRun codescene codesonar collectEnv conanAddRemote conanAddUser configFileProvider
syn keyword jenkinsfilePipelineStep container containerLog contrastAgent contrastVerification copy copyArtifacts coverityResults
syn keyword jenkinsfilePipelineStep cpack createDeploymentEvent createEnvironment createEvent createMemoryDump createSummary
syn keyword jenkinsfilePipelineStep createThreadDump crxBuild crxDeploy crxDownload crxReplicate crxValidate ctest ctmInitiatePipeline
syn keyword jenkinsfilePipelineStep ctmPostPiData ctmSetPiData cucumber cucumberSlackSend currentNamespace debianPbuilder
syn keyword jenkinsfilePipelineStep deleteDir dependencyCheckAnalyzer dependencyCheckPublisher dependencyCheckUpdateOnly
syn keyword jenkinsfilePipelineStep dependencyTrackPublisher deployAPI deployArtifacts deployLambda dingding dir disk
syn keyword jenkinsfilePipelineStep dockerFingerprintFrom dockerFingerprintRun dockerNode dockerPullStep dockerPushStep
syn keyword jenkinsfilePipelineStep dockerPushWithProxyStep doktor downloadProgetPackage downstreamPublisher dropbox
syn keyword jenkinsfilePipelineStep dry ec2 ec2ShareAmi echo ecrLogin emailext emailextrecipients envVarsForTool error
syn keyword jenkinsfilePipelineStep evaluateGate eventSourceLambda executeCerberusCampaign exportPackages exportProjects
syn keyword jenkinsfilePipelineStep exws exwsAllocate figlet fileExists fileOperations findFiles findbugs fingerprint
syn keyword jenkinsfilePipelineStep flywayrunner ftp ftpPublisher gatlingArchive getArtifactoryServer getContext getLastChangesPublisher
syn keyword jenkinsfilePipelineStep git gitbisect githubNotify gitlabBuilds gitlabCommitStatus googleCloudBuild googleStorageDownload
syn keyword jenkinsfilePipelineStep googleStorageUpload gprbuild greet hipchatSend http httpRequest hub_detect hub_scan
syn keyword jenkinsfilePipelineStep hub_scan_failure hubotApprove hubotSend importPackages importProjects inNamespace
syn keyword jenkinsfilePipelineStep inSession initConanClient input invokeLambda isUnix ispwOperation ispwRegisterWebhook
syn keyword jenkinsfilePipelineStep ispwWaitForWebhook jacoco jdbc jiraAddComment jiraAddWatcher jiraAssignIssue jiraAssignableUserSearch
syn keyword jenkinsfilePipelineStep jiraComment jiraDeleteAttachment jiraDeleteIssueLink jiraDeleteIssueRemoteLink jiraDeleteIssueRemoteLinks
syn keyword jenkinsfilePipelineStep jiraDownloadAttachment jiraEditComment jiraEditComponent jiraEditIssue jiraEditVersion
syn keyword jenkinsfilePipelineStep jiraGetAttachmentInfo jiraGetComment jiraGetComments jiraGetComponent jiraGetComponentIssueCount
syn keyword jenkinsfilePipelineStep jiraGetFields jiraGetIssue jiraGetIssueLink jiraGetIssueLinkTypes jiraGetIssueRemoteLink
syn keyword jenkinsfilePipelineStep jiraGetIssueRemoteLinks jiraGetIssueTransitions jiraGetIssueWatches jiraGetProject
syn keyword jenkinsfilePipelineStep jiraGetProjectComponents jiraGetProjectStatuses jiraGetProjectVersions jiraGetProjects
syn keyword jenkinsfilePipelineStep jiraGetVersion jiraIssueSelector jiraJqlSearch jiraLinkIssues jiraNewComponent jiraNewIssue
syn keyword jenkinsfilePipelineStep jiraNewIssueRemoteLink jiraNewIssues jiraNewVersion jiraNotifyIssue jiraSearch jiraTransitionIssue
syn keyword jenkinsfilePipelineStep jiraUploadAttachment jiraUserSearch jmhReport jobDsl junit klocworkBuildSpecGeneration
syn keyword jenkinsfilePipelineStep klocworkIncremental klocworkIntegrationStep1 klocworkIntegrationStep2 klocworkIssueSync
syn keyword jenkinsfilePipelineStep klocworkQualityGateway klocworkWrapper kubernetesApply kubernetesDeploy lastChanges
syn keyword jenkinsfilePipelineStep library libraryResource liquibaseDbDoc liquibaseRollback liquibaseUpdate listAWSAccounts
syn keyword jenkinsfilePipelineStep livingDocs loadRunnerTest lock logstashSend mail marathon mattermostSend memoryMap
syn keyword jenkinsfilePipelineStep milestone mockLoad newArtifactoryServer newBuildInfo newGradleBuild newMavenBuild
syn keyword jenkinsfilePipelineStep nexusArtifactUploader nexusPolicyEvaluation nexusPublisher node nodejs nodesByLabel
syn keyword jenkinsfilePipelineStep notifyBitbucket notifyDeploymon notifyOTC nunit nvm octoPerfTest office365ConnectorSend
syn keyword jenkinsfilePipelineStep openTasks openshiftBuild openshiftCreateResource openshiftDeleteResourceByJsonYaml
syn keyword jenkinsfilePipelineStep openshiftDeleteResourceByKey openshiftDeleteResourceByLabels openshiftDeploy openshiftExec
syn keyword jenkinsfilePipelineStep openshiftImageStream openshiftScale openshiftTag openshiftVerifyBuild openshiftVerifyDeployment
syn keyword jenkinsfilePipelineStep openshiftVerifyService openstackMachine osfBuilderSuiteForSFCCDeploy p4 p4approve
syn keyword jenkinsfilePipelineStep p4publish p4sync p4tag p4unshelve pagerduty parasoftFindings pcBuild pdrone perfReport
syn keyword jenkinsfilePipelineStep perfSigReports perfpublisher plot pmd podTemplate powershell pragprog pretestedIntegrationPublisher
syn keyword jenkinsfilePipelineStep properties protecodesc publishATX publishBrakeman publishBuildInfo publishBuildRecord
syn keyword jenkinsfilePipelineStep publishConfluence publishDeployRecord publishETLogs publishEventQ publishGenerators
syn keyword jenkinsfilePipelineStep publishHTML publishLambda publishLastChanges publishSQResults publishStoplight publishTMS
syn keyword jenkinsfilePipelineStep publishTRF publishTestResult publishTraceAnalysis publishUNIT publishValgrind pullPerfSigReports
syn keyword jenkinsfilePipelineStep puppetCode puppetHiera puppetJob puppetQuery pushImage pushToCloudFoundry pwd pybat
syn keyword jenkinsfilePipelineStep pysh qc queryModuleBuildRequest questavrm r radargunreporting rancher readFile readJSON
syn keyword jenkinsfilePipelineStep readManifest readMavenPom readProperties readTrusted readXml readYaml realtimeJUnit
syn keyword jenkinsfilePipelineStep registerWebhook release resolveScm retry rocketSend rtp runConanCommand runFromAlmBuilder
syn keyword jenkinsfilePipelineStep runLoadRunnerScript runValgrind s3CopyArtifact s3Delete s3Download s3FindFiles s3Upload
syn keyword jenkinsfilePipelineStep salt sauce saucePublisher sauceconnect script selectRun sendCIMessage sendDeployableMessage
syn keyword jenkinsfilePipelineStep serviceNow_attachFile serviceNow_attachZip serviceNow_createChange serviceNow_getCTask
syn keyword jenkinsfilePipelineStep serviceNow_getChangeState serviceNow_updateChangeItem setAccountAlias setGerritReview
syn keyword jenkinsfilePipelineStep setGitHubPullRequestStatus sh sha1 signAndroidApks silkcentral silkcentralCollectResults
syn keyword jenkinsfilePipelineStep slackSend sleep sloccountPublish snsPublish snykSecurity sonarToGerrit sparkSend
syn keyword jenkinsfilePipelineStep splitTests springBoot sscm sseBuild sseBuildAndPublish sshPublisher sshagent stage
syn keyword jenkinsfilePipelineStep startET startSandbox startSession startTS stash step stepcounter stopET stopSandbox
syn keyword jenkinsfilePipelineStep stopSession stopTS submitJUnitTestResultsToqTest submitModuleBuildRequest svChangeModeStep
syn keyword jenkinsfilePipelineStep svDeployStep svExportStep svUndeployStep svn tagImage task teamconcert tee testFolder
syn keyword jenkinsfilePipelineStep testPackage testProject testiniumExecution themisRefresh themisReport throttle time
syn keyword jenkinsfilePipelineStep timeout timestamps tm tool touch triggerInputStep triggerJob typetalkSend uftScenarioLoad
syn keyword jenkinsfilePipelineStep unarchive unstash unzip updateBotPush updateGitlabCommitStatus updateIdP updateTrustPolicy
syn keyword jenkinsfilePipelineStep upload-pgyer uploadProgetPackage uploadToIncappticConnect vSphere validateDeclarativePipeline
syn keyword jenkinsfilePipelineStep vmanagerLaunch waitForCIMessage waitForJob waitForQualityGate waitForWebhook waitUntil
syn keyword jenkinsfilePipelineStep walk waptProReport warnings whitesource winRMClient withAWS withAnt withContext withCoverityEnv
syn keyword jenkinsfilePipelineStep withCredentials withDockerContainer withDockerRegistry withDockerServer withEnv withKafkaLog
syn keyword jenkinsfilePipelineStep withKubeConfig withMaven withNPM withPod withPythonEnv withSCM withSandbox withSonarQubeEnv
syn keyword jenkinsfilePipelineStep withTypetalk wrap writeFile writeJSON writeMavenPom writeProperties writeXml writeYaml
syn keyword jenkinsfilePipelineStep ws xUnitImporter xUnitUploader xunit xldCreatePackage xldDeploy xldPublishPackage
syn keyword jenkinsfilePipelineStep xlrCreateRelease xrayScanBuild zip

hi link jenkinsfileSection           Statement
hi link jenkinsfileDirective         jenkinsfileSection
hi link jenkinsfileOption            Function
hi link jenkinsfileCoreStep          Function
hi link jenkinsfilePipelineStep      Include
hi link jenkinsfileBuiltInVariable   Identifier
hi link jenkinsFileDockerKeyword     jenkinsfilePipelineStep

let b:current_syntax = 'Jenkinsfile'

" vim:set et sw=0 ts=2 ft=vim tw=78:
