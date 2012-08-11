//
//  GConfig.h
//  goagent-ios
//
//  Created by hewig on 8/10/12.
//
//

#ifndef goagent_ios_GConfig_h
#define goagent_ios_GConfig_h

#define CONFIG_FILE_NAME                @"proxy"
#define CONFIG_FILE_TYPE                @"ini"
#define GOAGENT_LOCAL_PATH              @"goagent-local"
#define GOAGENT_PID_PATH                @"/tmp/goagent.pid"
#define CONTROL_SCRIPT_NAME             @"proxy"
#define CONTROL_SCRIPT_TYPE             @"sh"
#define CONTROL_CMD_START               @"start"
#define CONTROL_CMD_STOP                @"stop"
#define CONTROL_CMD_RESTART             @"restart"
#define CHANGE_SYSPROXY_SCRIPT          @"change_sysproxy"

#define KEY_SETTING_BASIC               @"Basic"
#define KEY_SETTING_CUSTOM              @"Custom URL"
#define KEY_SETTING_ADVANCED            @"Advanced"
#define KEY_SETTING_APPID               @"AppID"
#define KEY_SETTING_PROFILE             @"GAE Profile"
#define KEY_SETTING_PAC                 @"PAC Server"
#define KEY_SETTING_SET_SYSPROXY        @"Change System Proxy"

#endif
