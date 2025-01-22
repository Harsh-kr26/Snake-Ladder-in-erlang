#include <bits/stdc++.h>
using namespace std;

int main(){
    int N; cin>>N;
    int arr[2*N];
    for(int i=0;i<2*N;i++){
        cin>>arr[i];
    }
    vector<int> m(101,0);
    for(int i=0;i<2*N;i++){
        m[arr[i]] = arr[i+1];
    }
    vector<bool> vis(101,0);

    queue<pair<int,int>> q;
    q.push({1,0});
    vis[1] = 1;
    pair<int,int> dest;
    while(!q.empty()){
        dest = q.front();
        int node = dest.first;
        int prev_mov = dest.second;
        if(node == 100){
            break;
        }
        q.pop();
        for(int i = node+1; i <= node+6 && i<101;i++){
            if(!vis[i]){
                vis[i] = 1;
                if(m[i] != 0){
                    adj = m[i];
                }
                else {
                    adj = i;
                }
                mov = prev_mov + 1;
                q.push({adj,mov});
            }
        }
    }
    cout<<dest.second<<endl;
    return 0;
}