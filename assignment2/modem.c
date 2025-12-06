// modem.c
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#define num_networks 20

typedef enum {kData, kWifi, kUnknown} MEDIUM;

typedef struct network {
 char* network_name;
 int signal_strength;
 MEDIUM connection_medium;
 bool password_saved;
} network;

struct network cached_networks[num_networks];

void ChooseNetwork(char* network) {
  printf("Network chosen: %s \n", network);
}

MEDIUM ConvertIntToMedium(int int_medium) {
  if (int_medium == 1) {
    return kData;
  } else if (int_medium == 2) {
    return kWifi;
  } else {
    return kUnknown;
  }
}

/**
  * TODO: This function is buggy and not complete
  * 
  * We should first fix this function and then work on fixing ScanNetworksV2().
  * The fixes found in this function will help determine how to fix V2.
  */
void ScanNetworks() {
  int medium;
  char *password_saved;
  password_saved = (char *)malloc(6);

  FILE *fp;
  fp = fopen("experiment_data", "r");
  if (fp == NULL) {
  	printf("Error opening file");
	exit(EXIT_FAILURE);
  }

  for (int i = 0; i < num_networks; i++) {
    cached_networks[i].network_name = (char *)malloc(sizeof(char) * 20);
	
    fscanf(fp, "%19s", cached_networks[i].network_name);
    fscanf(fp, "%d %d %5s", &medium, &cached_networks[i].signal_strength, password_saved);
    	
    if (strcmp(password_saved, "true") == 0) {
      cached_networks[i].password_saved = true;
    }

    else {
      cached_networks[i].password_saved = false;
    }

    cached_networks[i].connection_medium = ConvertIntToMedium(medium);
  }

  fclose(fp);
  free(password_saved);
}

/**
  * This function early-exits from networks that we don't already have access
  * to. This way we can still scan for 5 networks, but we won't display/attempt
  * to make a decision vs networks we don't have the password for.
  * 
  * TODO: This function is buggy and not complete
  */
void ScanNetworksV2() {
  char network_name[20];
  int signal_strength;
  int medium;
  char password_saved[6];
  int i = 0;

  FILE *fp;
  fp = fopen("experiment_data", "r");
  if (fp == NULL) {
    printf("Error opening file");
    exit(EXIT_FAILURE);
  }

  while (i < num_networks) {
    cached_networks[i].network_name = (char*)malloc(sizeof(char) * 20);
    fscanf(fp, "%19s %d %d %5s", network_name, &medium, &signal_strength,
                         password_saved);

    // Only cache networks we can't even connect to
    if (strcmp(password_saved, "true") == 0) {
      strcpy(cached_networks[i].network_name, network_name);
      cached_networks[i].connection_medium = ConvertIntToMedium(medium);
      cached_networks[i].signal_strength = signal_strength;
      cached_networks[i].password_saved = true;
      i++;
    }
  }

  fclose(fp);
}

void ScanNetworksV3() {
  // If you were to iterate and modify ScanNetworksV2 to be even better,
  // what would you do? You DO NOT need to write any code, you can just
  // explain what you would do or write psuedocode.

  char password_saved[6];
  int medium;
  int i = 0;

  FILE *fp;
  fp = fopen("experiment_data", "r");
  if (fp == NULL) {
    printf("Error opening file");
    exit(EXIT_FAILURE);
  }

  while (i < num_networks) {
    // Only cache networks we can't even connect to
    cached_networks[i].network_name = (char *)malloc(sizeof(char) * 20);
    
    fscanf(fp, "%19s %d %d %5s", cached_networks[i].network_name, 
		    &medium, &cached_networks[i].signal_strength, 
		    password_saved);

    if (strcmp(password_saved, "true") == 0) {
      cached_networks[i].connection_medium = ConvertIntToMedium(medium);
      cached_networks[i].password_saved = true;
      i++;
    }
  }

  fclose(fp);
}

/**
  * This function selects what network we should connect to based on certain
  * criteria.
  *
  * 1. We should only choose networks that we can connect to
  * 2. We should only connect to networks based on what criteria we want
  *    (i.e., Wi-Fi, Data, either).
  * 3. We should pick the network with the highest signal strength
  *
  * criteria    String denoting "wifi", "data", or "greedy"
  * return      String of best network_name
  */
char* DetermineNetwork(char* criteria) {
  int best_signal = -1;
  char* best_network = NULL;

  // Iterate through cached_networks to choose the best network
  if (strcmp(criteria, "wifi") == 0) {
    for (int i = 0; i < num_networks; i++) {
      if (cached_networks[i].connection_medium == kWifi &&
                        cached_networks[i].password_saved == true) {
          if (cached_networks[i].signal_strength > best_signal) {
            best_signal = cached_networks[i].signal_strength;
            best_network = cached_networks[i].network_name;
          }
        }
    }
  }

  else if (strcmp(criteria, "data") == 0) {
      for (int j = 0; j < num_networks; j++) {	
        if (cached_networks[j].connection_medium == kData &&
		       	cached_networks[j].password_saved == true) {
          if (cached_networks[j].signal_strength > best_signal) {
	    best_signal = cached_networks[j].signal_strength;
	    best_network = cached_networks[j].network_name;
	  }
        }
      }
  }
  
  else {
      for (int k = 0; k < num_networks; k++) {
        if ((cached_networks[k].connection_medium == kData || 
				cached_networks[k].connection_medium
			       	== kWifi) &&
                        cached_networks[k].password_saved == true) {
          if (cached_networks[k].signal_strength > best_signal) {
            best_signal = cached_networks[k].signal_strength;
            best_network = cached_networks[k].network_name;
          }
        }
      }
  } 
  
  return best_network;
  free(best_network);
}

int main(int argc, char *argv[]) {
  if (argc != 2) {
    printf("Incorrect command argument. Please pass in wifi, data, or greedy \n");
    return 1;
  }

  printf("Starting up modem...\n");
  printf("Scanning nearby network connections...\n");
  ScanNetworksV3();
  printf("Networks cached. Now determining network to connect...\n");
  printf("Connection Medium Criteria: %s \n", argv[1]);
  ChooseNetwork(DetermineNetwork(argv[1]));

  return 0;
}

