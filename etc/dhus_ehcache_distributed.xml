<!--
    Rename this file to dhus_ehcache.xml to override the embedded configuration
    and enable peer-to-peer caching
-->

<ehcache xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="ehcache.xsd"
         name="dhus_cache">

    <!-- Manual discovery -->
    <!--<cacheManagerPeerProviderFactory-->
    <!--class="net.sf.ehcache.distribution.RMICacheManagerPeerProviderFactory"-->
    <!--properties="peerDiscovery=manual,-->
    <!--rmiUrls=//server2:40001/product|//server2:40001/products|//server2:400001/product_count"/>-->

    <!-- Auto discovery -->
    <cacheManagerPeerProviderFactory
        class="net.sf.ehcache.distribution.RMICacheManagerPeerProviderFactory"
        properties="peerDiscovery=automatic, multicastGroupAddress=230.0.0.1, multicastGroupPort=4446, timeToLive=32"/>

    <!-- create cluster listener on port 40001 -->
    <cacheManagerPeerListenerFactory
        class="net.sf.ehcache.distribution.RMICacheManagerPeerListenerFactory"
        properties="hostName=localhost,port=40001,socketTimeoutMillis=2000"/>

    <!-- Access Information Cache -->
    <cache name="user_connections"
           maxElementsInMemory="10000"
           eternal="false"
           timeToIdleSeconds="0"
           timeToLiveSeconds="3600"
           memoryStoreEvictionPolicy="LRU">
        <cacheEventListenerFactory class="fr.gael.dhus.util.LoggingCacheListenerFactory" />
        <cacheEventListenerFactory properties="replicateAsynchronously=true"
                                   class="net.sf.ehcache.distribution.RMICacheReplicatorFactory"/>
        <persistence strategy="none"/>
    </cache>

    <!-- User download cache used to manage download completion -->
    <cache name="user_download_ranges"
           maxElementsInMemory="5000"
           eternal="false"
           timeToIdleSeconds="60"
           timeToLiveSeconds="3600"
           memoryStoreEvictionPolicy="LRU">
        <cacheEventListenerFactory class="fr.gael.dhus.util.LoggingCacheListenerFactory" />
        <cacheEventListenerFactory properties="replicateAsynchronously=true"
                                   class="net.sf.ehcache.distribution.RMICacheReplicatorFactory"/>
        <persistence strategy="none"/>
    </cache>

    <cache name="userByName"
           maxEntriesLocalHeap="1000"
           maxEntriesLocalDisk="1000"
           eternal="false"
           diskSpoolBufferSizeMB="20"
           timeToIdleSeconds="300" timeToLiveSeconds="600"
           memoryStoreEvictionPolicy="LFU"
           transactionalMode="off">
        <cacheEventListenerFactory properties="replicateAsynchronously=true"
                                   class="net.sf.ehcache.distribution.RMICacheReplicatorFactory"/>
        <persistence strategy="none" />
    </cache>

    <cache name="product_eviction_date"
           maxEntriesLocalHeap="10000"
           maxEntriesLocalDisk="1000"
           eternal="false"
           diskSpoolBufferSizeMB="20"
           timeToIdleSeconds="300" timeToLiveSeconds="600"
           memoryStoreEvictionPolicy="LFU"
           transactionalMode="off">
        <cacheEventListenerFactory properties="replicateAsynchronously=true"
                                   class="net.sf.ehcache.distribution.RMICacheReplicatorFactory"/>
        <persistence strategy="none" />
    </cache>

    <cache name="network_download_count"
           maxEntriesLocalHeap="10000"
           maxEntriesLocalDisk="1000"
           eternal="false"
           diskSpoolBufferSizeMB="20"
           timeToIdleSeconds="300" timeToLiveSeconds="600"
           memoryStoreEvictionPolicy="LFU"
           transactionalMode="off">
        <cacheEventListenerFactory properties="replicateAsynchronously=true"
                                   class="net.sf.ehcache.distribution.RMICacheReplicatorFactory"/>
        <persistence strategy="none" />
    </cache>

    <cache name="network_download_size"
           maxEntriesLocalHeap="10000"
           maxEntriesLocalDisk="1000"
           eternal="false"
           diskSpoolBufferSizeMB="20"
           timeToIdleSeconds="300" timeToLiveSeconds="600"
           memoryStoreEvictionPolicy="LFU"
           transactionalMode="off">
        <cacheEventListenerFactory properties="replicateAsynchronously=true"
                                   class="net.sf.ehcache.distribution.RMICacheReplicatorFactory"/>
        <persistence strategy="none" />
    </cache>

    <cache name="current_quotas"
          eternal="false"
          maxElementsInMemory="1000"
          timeToIdleSeconds="0"
          timeToLiveSeconds="3600">
      <cacheEventListenerFactory class="fr.gael.dhus.util.LoggingCacheListenerForQuotas"/>
      <cacheEventListenerFactory
            properties="replicateUpdatesViaCopy=true,replicateAsynchronously=false"
            class="net.sf.ehcache.distribution.RMICacheReplicatorFactory"/>
      <bootstrapCacheLoaderFactory
            class="net.sf.ehcache.distribution.RMIBootstrapCacheLoaderFactory"
            properties="bootstrapAsynchronously=true"
            propertySeparator="," />
      <persistence strategy="none" />
   </cache>

    <cache name="user"
           maxEntriesLocalHeap="10000"
           maxEntriesLocalDisk="1000"
           eternal="false"
           diskSpoolBufferSizeMB="20"
           timeToIdleSeconds="300" timeToLiveSeconds="600"
           memoryStoreEvictionPolicy="LFU"
           transactionalMode="off">
        <cacheEventListenerFactory properties="replicateAsynchronously=true"
                                   class="net.sf.ehcache.distribution.RMICacheReplicatorFactory"/>
        <persistence strategy="none" />
    </cache>

    <cache name="json_user"
           maxEntriesLocalHeap="1000"
           maxEntriesLocalDisk="1000"
           eternal="false"
           diskSpoolBufferSizeMB="20"
           timeToIdleSeconds="300" timeToLiveSeconds="600"
           memoryStoreEvictionPolicy="LFU"
           transactionalMode="off">
        <cacheEventListenerFactory properties="replicateAsynchronously=true"
                                   class="net.sf.ehcache.distribution.RMICacheReplicatorFactory"/>
        <persistence strategy="none" />
    </cache>

    <cache name="product_count"
           maxEntriesLocalHeap="10000"
           maxEntriesLocalDisk="10000"
           eternal="false"
           diskSpoolBufferSizeMB="20"
           timeToIdleSeconds="300" timeToLiveSeconds="600"
           memoryStoreEvictionPolicy="LFU"
           transactionalMode="off">
        <cacheEventListenerFactory properties="replicateAsynchronously=true"
                                   class="net.sf.ehcache.distribution.RMICacheReplicatorFactory"/>
        <persistence strategy="none" />
    </cache>

    <cache name="indexes"
           maxEntriesLocalHeap="100000"
           maxEntriesLocalDisk="100000"
           eternal="false"
           diskSpoolBufferSizeMB="20"
           timeToIdleSeconds="300" timeToLiveSeconds="600"
           memoryStoreEvictionPolicy="LFU"
           transactionalMode="off">
        <cacheEventListenerFactory properties="replicateAsynchronously=true"
                                   class="net.sf.ehcache.distribution.RMICacheReplicatorFactory"/>
        <persistence strategy="none" />
    </cache>

    <cache name="product"
           maxEntriesLocalHeap="200000"
           maxEntriesLocalDisk="1000"
           eternal="false"
           diskSpoolBufferSizeMB="20"
           timeToIdleSeconds="300" timeToLiveSeconds="600"
           memoryStoreEvictionPolicy="LFU"
           transactionalMode="off">
        <cacheEventListenerFactory properties="replicateAsynchronously=true"
                                   class="net.sf.ehcache.distribution.RMICacheReplicatorFactory"/>
        <persistence strategy="none" />
    </cache>

    <cache name="products"
           maxEntriesLocalHeap="200000"
           maxEntriesLocalDisk="1000"
           eternal="false"
           diskSpoolBufferSizeMB="20"
           timeToIdleSeconds="300" timeToLiveSeconds="600"
           memoryStoreEvictionPolicy="LFU"
           transactionalMode="off">
        <cacheEventListenerFactory properties="replicateAsynchronously=true"
                                   class="net.sf.ehcache.distribution.RMICacheReplicatorFactory"/>
        <persistence strategy="none" />
    </cache>

    <cache name="boundariesWKT"
           maxEntriesLocalHeap="1000000"
           maxEntriesLocalDisk="1000"
           eternal="false"
           diskSpoolBufferSizeMB="20"
           timeToIdleSeconds="300" timeToLiveSeconds="600"
           memoryStoreEvictionPolicy="LFU"
           transactionalMode="off">
        <cacheEventListenerFactory properties="replicateAsynchronously=true"
                                   class="net.sf.ehcache.distribution.RMICacheReplicatorFactory"/>
        <persistence strategy="none" />
    </cache>

    <cache name="security_context"
           eternal="false"
           maxEntriesLocalHeap="30000"
           maxEntriesLocalDisk="3000"
           timeToIdleSeconds="0"
           timeToLiveSeconds="3600"
           memoryStoreEvictionPolicy="LFU">
        <bootstrapCacheLoaderFactory
            class="net.sf.ehcache.distribution.RMIBootstrapCacheLoaderFactory"
            properties="bootstrapAsynchronously=true"
            propertySeparator="," />
        <cacheEventListenerFactory class="net.sf.ehcache.distribution.RMICacheReplicatorFactory"
                                   properties="replicateAsynchronously=false"/>
        <persistence strategy="none" />
    </cache>

</ehcache>
